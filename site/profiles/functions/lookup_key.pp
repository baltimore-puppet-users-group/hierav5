function profiles::lookup_key(
	Variant[String, Numeric] $key,
	Hash										 $options,
	Puppet::LookupContext    $context,
) {
	if ($key == "profiles::ntp::keys_file") {
		"/etc/ntp/key2"
	} else {
		$context.not_found
	}
}
