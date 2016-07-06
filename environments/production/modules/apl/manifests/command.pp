

class apl::command::rsync_yum_repos
	{
	require apl::package::rsync
	require apl::file::etc_yum_repos_d
	
	# sanity check scope; don't want to collide with rsync_opt_local(!) 
	$rsync_source = "reposerver::${facts[os][name]}/${facts[os][release][major]}/etc/yum.repos.d/"
	
	exec { "rsync-yum-repos":
		command => "rsync -a --delete $rsync_source . ",
		cwd => "/etc/yum.repos.d/",
		path => "/usr/bin:/bin",
		}
	} 

class apl::command::rsync_opt_local 
	{ 
	require apl::package::rsync
	require file::opt_local

	# sanity check scope; don't want to collide with rsync_yum_repos(!) 
	$rsync_source = ""
	
	exec { 'rsync_opt_local': 
		cwd => "/opt/local",
		command => "/usr/bin/rsync -a --delete $rsync_source .",
		path => "/usr/bin:/bin",
		} 
	} 
	
class apl::command::grubpass_from_root
	{
	require apl::bundle::opt_local
	require apl::user::root

	exec { "grubpass_from_root":
		command => "/opt/local/bin/grubpass_from_root",
		cwd => "/",
		path => "/usr/bin:/bin:/usr/sbin:/sbin:/opt/local/bin",
		} 
	}

#
# Centos 6; disable X login screen user list. 
#
class apl::command::disable_x_user_list
	{
	exec { "disable_x_user_list":
		command => "gconftool-2 --direct --config-source-=xml:readwrite:/etc/gconf/gconf.xml.mandatory --type boolean --set /apps/gdm/simple-greeter/disable_user_list true",
		path => '/usr/bin:/bin:/usr/sbin:/sbin',
		onlyif => " [ 'gconftool-2 --get /apps/gdm/simple-greeter/disable_user_list' = 'false' ]",
		} 
	}

#
# put DoD banner above X login dialog box 
#
class apl::command::x_login_banner 
	{ 
	exec { "x_login_banner": 
		command => "gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /apps/gdm/simple-greeter/banner_message_text 'sample banner text'",
		path => "/usr/bin:/bin:/usr/sbin:/sbin",
		}
	}

class apl::command::log_root_password_change
	{
	exec {"logger -p authpriv.notice 'password changed for root'":
		cwd => '/tmp',
		path => '/usr/bin:/bin:/usr/sbin:/sbin',
		# This only runs if it has been told to 'refresh', for example by a 'notify' from another class.
		# This lets us include it but only run it selectively.  
		refreshonly => true,
		}
	}

class apl::command::clean_puppetserver_reports
	{
	exec { 'clean_puppetserver_reports':
		command => "find /opt/puppetlabs/server/data/puppetserver/reports -mount -name \'*.yaml\' -type f -mtime +1 -exec /bin/rm -f {} \;'",
		cwd => '/opt/puppetlabs/server/data/puppetserver/reports',
		path => '/usr/bin:/bin:/usr/sbin:/sbin',
		} 
	}

class apl::command::opt_local_bin_cron_rootpass {
	exec { '/opt/local/bin/cron_rootpass': 
		command => "/opt/local/bin/cron_rootpass",
		cwd => '/tmp',
		path => '/usr/bin:/bin:/usr/sbin:/sbin:/opt/local/bin',
		}
	} 


	
	
