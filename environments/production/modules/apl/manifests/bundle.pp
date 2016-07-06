
class apl::bundle::baseline
	{ 
	include apl::bundle::repodata
	include apl::bundle::package_baseline
	
	include apl::service::sshd
	include apl::service::crond
	include apl::service::smartd
	include apl::service::no_bluetooth
	include apl::service::no_abrtd
	include apl::service::no_abrtd_ccpp

#	include apl::user::root
	include apl::command::grubpass_from_root

	include apl::file::roothome
	include apl::file::root
	include apl::file::tmp
	include apl::file::var_tmp
	include apl::file::etc_rc_d
	include apl::file::etc_init_d
	include apl::file::var_log

	include apl::file::etc_resolv_conf
	include apl::file::etc_nsswitch_conf
	} 

class apl::bundle::package_baseline
	{ 
	include apl::package::sharutils
	include apl::package::tcpdump
	include apl::package::nmap
	include apl::package::strace
	include apl::package::xinetd
	include apl::package::openssl
	include apl::package::openssh
	include apl::package::xterm
	include apl::package::xscreensaver
	include apl::package::sysstat
	include apl::package::tzdata
	include apl::package::zip
	}

class apl::bundle::repodata
	{ 
	require apl::file::etc_yum_repos_d
	include apl::command::rsync_yum_repos
	} 

class apl::bundle::opt_local
	{ 
	} 

class apl::bundle::adminonly
	{ 
	include apl::password::root::unclass::adminonly
        }

class apl::bundle::useraccess 
	{ 
        include apl::password::root::unclass::useraccess
	} 
