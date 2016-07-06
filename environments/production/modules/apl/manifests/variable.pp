
class apl::variable
	{ 
	$osversion = "${facts[os][name]}${facts[os][release][major]"}"
	$arch = "${facts[os][architecture]}"
	$hostname = "${facts[networking][hostname]}"
	$virtual = "${facts[is_virtual]"
	} 
