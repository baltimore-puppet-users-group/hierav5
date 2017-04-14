class profiles::params {
  case $::osfamily {
 
      'Debian': {
         $config = "/etc/ntp.conf"
         $keys_file = '/etc/ntp/keys'
      }
 
      'RedHat': {
         $config = "/etc/ntp.conf"
         $keys_file = '/etc/ntp/keys'
      }
   }
}
