
class apl::mount::example
	{ 
	mount { '/mount/name':
		device => remoteserver:/path,
		ensure => mounted,
		atboot => true,
		fstype => 'nfs',
		options => 'vers=3,tcp,ro',
		} 
	} 
