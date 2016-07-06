
class apl::file::etc_ssh_knownhosts
	{
	file { "/etc/ssh/ssh_known_hosts":
		ensure => 'file',
		owner => 'root',
		group => 'root',
		mode => '0644',
		} 
	}

class apl::file::remove_etc_nologin
	{
	file { '/etc/nologin':
		ensure => 'absent',
		}
	}

class apl::file::etc
	{
	file { '/etc':
		ensure => 'directory',
		owner => 'root',
		group => root,
		mode => '0755',
		} 
	}

class apl::file::etc_ssh
	{
	file { '/etc/ssh':
		ensure => directory,
		owner => root,
		group => root,
		mode => '0755i',
		} 
	} 

class apl::file::etc_sudoers
	{ 
	file { '/etc/sudoers':
		ensure => file,
		owner => root,
		group => root,
		mode => '0400',
		source => "puppet:///modules/apl/etc/sudoers",
		} 
	} 

class apl::file::etc_pam_d_system_auth { 

	$pam_system_auth_target = "puppet:///modules/apl/etc/pam.d/system-auth.${facts[os][name]}${facts[os][release][major]}"

	file { '/etc/pam.d/system-auth': 
		ensure => file,
		owner => root,
		group => root,
		mode => '0644',
		source => $pam_system_auth_target,
		force => true,
		} 
	} 

class apl::file::etc_pam_d_system_auth_ac { 
	file { '/etc/pam.d/system-auth-ac': 
		ensure => file,
		owner => root,
		group => root,
		mode => '0644',
		source => "puppet:///modules/apl/etc/pam.d/system-auth-ac",
		} 
	} 

class apl::file::etc_pam_d_system_auth_ac {

        require apl::file::etc_pam_d_system_auth

        file { '/etc/pam.d/system-auth-ac':
                ensure => link,
                target => 'system-auth',
                force => true,
                backup => false,
                }
        }

class apl::file::etc_pam_d_password_auth { 

        $pam_password_auth_target = "puppet:///modules/apl/etc/pam.d/password-auth.${facts[os][name]}${facts[os][release][major]}"

	file { '/etc/pam.d/password-auth':
                ensure => file,
                owner => root,
                group => root,
                mode => '0644',
                source => "puppet:///modules/apl/etc/pam.d/password-auth",
                }
	} 

class apl::file::etc_pam_d_password_auth_ac {

	require apl::file::etc_pam_d_password_auth
	
        file { '/etc/pam.d/password-auth-ac':
                ensure => link,
                target => 'password-auth',
		force => true,
		backup => false,
                }
        }

class apl::file::etc_nagios
	{ 
	require apl::package::nagios_common

	file { '/etc/nagios':
		ensure => 'directory',
		owner => 'root',
		group => 'root',
		mode => '0755',
		} 
	} 

class apl::file::var_log
	{ 
	file { '/var/log':
		ensure => directory,
		mode => '0755',
		owner => root,
		group => root,
		} 
	} 

class apl::file::var_log_audit
	{ 
	file { '/var/log/audit': 
		ensure => directory,
		mode => '0750',
		owner => root,
		group => root,
		} 
	} 

class apl::file::etc_audit_audit_rules { 
	file { '/etc/audit/audit.rules': 
		ensure => 'file',
		owner => root,
		group => root,
		mode => '0600',
		source => 'puppet:///modules/apl/audit/audit.rules',
		require => Package['audit'],
		notify => Service['auditd'],
		} 
	} 

class apl::file::etc_audit_auditd_conf { 
	file { '/etc/audit/auditd.conf':
		ensure => file,
		owner => root,
		group => root,
		mode => '0600',
		source => 'puppet:///modules/apl/audit/auditd.conf',
		require => Package['audit'],
		notify => Service['auditd'],
		} 
	} 

class apl::file::etc_ntp_conf { 
	file { '/etc/ntp.conf':
		ensure => file,
		owner => root,
		group => root,
		mode => '0644',
		source => 'puppet:///modules/apl/etc/resolv.conf',
		} 
	} 

class apl::file::etc_resolv_conf
	{
	file { '/etc/resolv.conf':
		owner => root,
		group => root,
		mode => '0644',
		source => 'puppet:///modules/apl/etc/resolv.conf',
		} 
	}
#
# this will be sticky, due to NIS/no NIS, etc. 
#
class apl::file::etc_nsswitch_conf { 
	
	
	} 

# The contents are controlled by apl::command::rsync_yum_repos; we 
# are just managing permissions here. 
class apl::file::etc_yum_repos_d { 
	file { '/etc/yum.repos.d/':
		ensure => directory,
		owner => root,
		group => root,
		mode => '0755',
		} 
	} 

class apl::file::etc_selinux_config
	{ 
	file { '/etc/selinux/config':
		ensure => file,
		owner => root,
		group => root,
		mode => '0644',
		force => true,
		backup => false,
		} 
	} 

class apl::file::etc_sysconfig_selinux 
	{ 
	file { '/etc/sysconfig/selinux': 
		ensure => file,
		owner => root,
		group => root,
		mode => '0644',
		source => 'puppet:///modules/apl/etc/sysconfig/selinux',
		backup => false,
		force => true,
		} 
	} 

class apl::file::etc_sysconfig_init
	{
	require apl::variable	
	
	$sourcefile = "puppet:///modules/apl/etc/sysconfig/init.${apl::variable::osversion}"
	
	file { '/etc/sysconfig/init':
		ensure => file,
		owner => root,
		group => root,
		mode => '0644',
		force => true,
		source => $sourcefile,
		links => follow,
		} 
	}

class apl::file::etc_login_defs
	{ 
	require apl::variable

        $sourcefile = "puppet:///modules/apl/etc/login.defs.${apl::variable::osversion}"

	file { '/etc/login.defs':
		ensure => file,
                owner => root,
                group => root,
                mode => '0644',
                force => true,
                source => $sourcefile,
                links => follow,
                }
	} 

class apl::file::etc_issue
	{ 
	file { '/etc/issue':
		ensure => file,
		mode => '0644',
		owner => root,
		group => root,
		source => 'puppet:///modules/apl/etc/issue',
		} 
	} 

class apl::file::etc_ssh_sshd_config
	{
	require apl::package::openssh

	file { '/etc/ssh/sshd_config':
		ensure => file,
		owner => root,
		group => root,
		mode => '0600',
		force => true,
		source => 'puppet:///modules/apl/etc/ssh/sshd_config',
		} 
	}

class apl::file::etc_ssh_ssh_config
        {
        require apl::package::openssh

        file { '/etc/ssh/ssh_config':
                ensure => file,
                owner => root,
                group => root,
                mode => '0600',
                force => true,
                source => 'puppet:///modules/apl/etc/ssh/ssh_config',
                }
        }

class apl::file::etc_ssh
        {
        require apl::package::openssh

        file { '/etc/ssh':
                ensure => directory,
                owner => root,
                group => root,
                mode => '0755',
                }
        }

class apl::file::var_nrpe
	{ 
	require apl::package::nrpe

	file { '/var/nrpe':
		ensure => directory,
		owner => nrpe,
		group => root,
		mode => '0755',
		} 
	} 

class apl::file::etc_nagios_nrpe_cfg
	{ 
	require apl::package::nagios_nrpe
	include apl::service::nrpe

	file { '/etc/nagios/nrpe.cfg':
		ensure => file,
		owner => root,
		group => root,
		mode => '0644',
		source => 'puppet:///modules/apl/nrpe/nrpe.cfg',
		links => follow,
		notify => Service['nrpe'],
		} 
	} 

class apl::file::etc_nrpe_d
	{ 
	require apl::package::nrpe

	file { '/etc/nrpe.d':
		ensure => directory,
		owner => root,
		group => root,
		mode => '0755',
		} 
	} 

class apl::file::root
	{ 
	file { 'root':
		path => "/",
		ensure => directory,
		owner => root,
		group => root,
		mode => '0755',
		} 
	} 

class apl::file::roothome
	{ 
	file { '/root':
		ensure => directory,
		owner => root,
		group => root,
		mode => '0700',
		} 
	} 

class apl::file::etc_init_d
	{ 
	file { '/etc/init.d':
		owner => root,
		group => root,
		mode => '0755',
		} 
	} 

class apl::file::etc_rc_d
	{ 
	file { '/etc/rc.d':
		owner => root,
		group => root,
		mode => '0755',
		} 
	} 

class apl::file::tmp
	{ 
	file { '/tmp':
		owner => root,
		group => root,
		mode => '1777',
		} 
	} 

class apl::file::var_tmp
	{ 
	file { '/var/tmp':
		owner => root,
		group => root,
		mode => '1777',
		} 
	} 

class apl::file::etc_rsyslog_conf
	{ 
	file { '/etc/rsyslog.conf':
		owner => root,
		group => root,
		mode => '0644',
		source => 'puppet:///modules/apl/etc/rsyslog.conf'
		} 
	} 

class apl::file::etc_puppetlabs_puppet_puppet_conf::client { 
	require apl::package::puppet
	include apl::service::puppet
	
	file { '/etc/puppetlabs/puppet/puppet.conf': 
		ensure => file,
		owner => root,
		group => root,
		mode => '0644',
		source => 'puppet:///modules/apl/etc/puppetlabs/puppet/puppet.conf.client',
		notify => Service['puppet'],
		} 
	} 

class apl::file::etc_puppetlabs_puppet_puppet_conf::server {
        require apl::package::puppet
        include apl::service::puppet

        file { '/etc/puppetlabs/puppet/puppet.conf':
                ensure => file,
                owner => root,
                group => root,
                mode => '0644',
                source => 'puppet:///modules/apl/etc/puppetlabs/puppet/puppet.conf.server',
                notify => Service['puppet'],
                }
        }

# Make sure nrpe can read the puppet run summary file 
class apl::file::opt_puppetlabs_puppet_cache { 
	require apl::package::nrpe
	file { '/opt/puppetlabs/puppet/cache':
		ensure => directory,
		owner => root,
		group => nagiosgrp,
		mode => '0750',
		
		} 
	} 

class apl::file::opt_puppetlabs_puppet_cache_client_data
	{ 
	require apl::package::nrpe

	file { '/opt/puppetlabs/puppet/cache/client_data': 
		ensure => directory,
		owner => root,
		group => nagiosgrp,
		mode => '0750',
		} 
	} 

class apl::file::etc_security
	{ 
	file { '/etc/security':
		ensure => directory,
		owner => root,
		group => root,
		mode => '0755',
		links => follow,
		} 
	} 

class apl::file::etc_security_limits_conf
	{ 
	file { '/etc/security/limits.conf':
		owner => root,
		group => root,
		mode => '0644',
		} 
	} 

class apl::file::etc_yp_conf
	{ 
	file { '/etc/yp.conf':
		owner => root,
		group => root,
		mode => '0644',
		source => 'puppet:///modules/apl/etc/yp.conf'
		} 
	} 
