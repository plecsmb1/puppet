
apl::cron::rootpass { 
	cron ('rootpass': 
		command => '/opt/local/bin/cron_rootpass',
		user => 'root',
		minute => 26,
		} 
	} 
