class profiles::ntp(
	$server = "192.168.42.5"
) {
	package { "ntp":
		ensure => 'installed',
		notify => Service['ntpd']
	}
	file { "/etc/ntp.conf":
		notify  => Service['ntpd'],
		content => "server ${server}\n",
	}
	service { 'ntpd':
		ensure => 'running',
		enable => true,
	}
}
