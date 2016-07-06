

class apl::service::sshd { 
	require apl::package::openssh
	require apl::file::etc_ssh_sshd_config
	require apl::file::etc_ssh_ssh_config
	
	service { 'sshd': 
		name => 'sshd',
		ensure => running,
		enable => true,
		# has a functional 'restart' option in its init script
		hasrestart => true,
		} 
	} 

class apl::service::auditd { 
	require apl::package::audit
	require apl::file::etc_audit_audit_rules
	require apl::file::etc_audit_auditd_conf
	
	service { 'auditd':
		ensure => running,
		enable => true,
		subscribe => [ 
			Package['audit'],
			File['/etc/audit/audit.rules'],
			File['/etc/audit/auditd.conf'],
			],
		} 
	} 

class apl::service::no_iptables { 
	service {  'iptables': 
		ensure => stopped,
		enable => false,
		} 
	} 

class apl::service::syslog { 
	require apl::package::syslog
	require apl::file::etc_syslog_conf
	
	service { 'syslog': 
		ensure => running,
		enable => true,
		subscribe => File['/etc/syslog.conf'],
		} 
	} 

class apl::service::no_syslog { 
	service { 'syslog': 
		ensure => stopped,
		enable => false,
		} 
	} 

class apl::service::rsyslog { 
	require apl::package::rsyslog
	require apl::file::rsyslog_conf

	service { 'rsyslog': 
		ensure => running,
		enable => true,
		subscribe => File['/etc/rsyslog.conf'],
		} 
	} 

class apl::service::syslog_ng { 
	require apl::package::syslog_ng
	require apl::file::etc_syslog_ng_conf
	
	service { 'syslog-ng': 
		ensure => running,
		enable => true,
		subscribe => File['/etc/syslog-ng.conf'],
		} 
	} 

class apl::service::apl_nvidia { 
	require apl::package::wget
	require apl::file::etc_init_d_apl_nvidia
	
	service { 'APL_nvidia': 
		enable => true,
		} 
	} 

class apl::service::autofs { 
	require apl::package::autofs

	service { 'autofs': 
		ensure => running,
		enable => true,
		hasrestart => true,
		} 
	} 

class apl::service::puppetserver { 
	require apl::package::puppetserver
	
	service { 'puppetserver':
		ensure => running,
		enable => true,
		} 
	} 

class apl::service::puppetdb { 
	require apl::package::puppetdb
	
	service { 'puppetdb': 
		ensure => running,
		enable => true,
		} 
	} 

class apl::service::puppet { 
	require apl::package::puppet
	
	service { 'puppet': 
		ensure => running,
		enable => true,
		} 
	} 

class apl::service::crond { 
	service { 'crond': 
		ensure => running,
		enable => true,
		} 
	} 

class apl::service::smartd { 
	require apl::package::smartmontools

	service { 'smartd': 
		ensure => running,
		enable => true,
		} 
	} 

class apl::service::ntpd { 
	require apl::file::etc_ntp_conf

	service{'ntpd':
		ensure => running,
		enable => true,
		} 
	} 

class apl::service::no_bluetooth { 
	service {'bluetooth': 
		ensure => stopped,
		enable => false,
		} 
	} 

class apl::service::no_wpa_supplicant { 
	service { 'wpa_supplicant': 
		ensure => stopped,
		enable => false,
		} 
	} 

class apl::service_no_networkmanager { 
	service { 'NetworkManager': 
		ensure => stopped,
		enable => false,
		} 
	} 

class apl::service::nrpe {
	service {'nrpe': 
		ensure => running,
		enable => true,
		} 
	} 

class apl::service::rsyncd { 
	require apl::service::xinetd
	require apl::package::rsync
	
	service {'rsync': 
		enable => true,
		} 
	} 

class apl::service::no_abrtd { 
	service { 'abrtd': 
		enable => false,
		ensure => stopped,
		} 
	} 

class apl::service::no_abrtd_ccpp {
        service { 'abrtd_ccpp':
                enable => false,
                ensure => stopped,
                }
        }


class apl::service::xinetd { 
	require apl::package::xinetd

	service { 'xinetd': 
		enable => true,
		ensure => running,
		require => [
				Package['xinetd'],
				],
		} 
	} 

class apl::service::ypbind { 
	
	service { 'ypbind':
		enable => true,
		ensure => running,
		require => [ 
				Package['ypbind'],
				File['/etc/yp.conf']
				],
		} 
	} 
