
class apl::user::root::nispom
	{
	include apl::command::log_root_password_change
	include apl::command::opt_local_bin_cron_rootpass
	
#	include some_class_with_root_crypt

	user { 'root':
		ensure => present,
#		password => $root_password_crypt,
		password => '$6$Km.707K/XjbhBo9w$lb.T4HhX1JcDY4mOUXCDL/YMsksIiBM5gniYRLK9FsHYRi7hBS6GhB92x2g64VWeEYCgnsPr4puXd7hnaRTFe1',		
		uid => 0,
		gid => 0,
		shell => '/bin/bash',
		expiry => '2016-07-31',
		password_max_age => '60',
		password_min_age => '1',
		notify => [ Class[apl::command::log_root_password_change], Class[apl::command::opt_local_bin_cron_rootpass] ],
		} 
	}

class apl::user::root::unclassified
	{
        include apl::command::log_root_password_change
        include apl::command::opt_local_bin_cron_rootpass

#       include some_class_with_root_crypt

        user { 'root':
                ensure => present,
#               password => $root_password_crypt,
                password => '$6$Km.707K/XjbhBo9w$lb.T4HhX1JcDY4mOUXCDL/YMsksIiBM5gniYRLK9FsHYRi7hBS6GhB92x2g64VWeEYCgnsPr4puXd7hnaRTFe1',
                uid => 0,
                gid => 0,
                shell => '/bin/bash',
                expiry => absent,
                password_max_age => 99999,
                password_min_age => 0,
                notify => [ Class[apl::command::log_root_password_change], Class[apl::command::opt_local_bin_cron_rootpass] ],
                }

	}
