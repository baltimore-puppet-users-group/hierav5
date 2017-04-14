function profiles::data_hash(
	Hash $options,
	Puppet::LookupContext $context,
) {
	  case $::osfamily {
      'Debian': { 
			  {
          "profiles::ntp::config" => "/etc/ntpd.conf",
          "profiles::ntp::keys_file" => '/etc/ntpd/keys',
				}
      }
      'RedHat': {
				{
          "profiles::ntp::config" => "/etc/ntp.conf",
          "profiles::ntp::keys_file" => '/etc/ntp/keys',
				}
      }
   }
}
