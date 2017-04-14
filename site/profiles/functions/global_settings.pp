function profiles::global_settings(
	Variant[String, Numeric] $key,
	Hash	 $options,
	Puppet::LookupContext    $context,
) {
	unless ($key == "lookup_options" or $key == "profiles::options_table" or $key == "profiles::options_defaults") {
		$options_table = lookup("profiles::options_table", {"default_value" => {}})
		$defaults_table = lookup("profiles::options_defaults", {"default_value" => {}})
		if ($options_table.has_key($key)) {
			$global_option = $options_table[$key]
			$value = lookup($global_option, { "default_value" => undef })

			if ($defaults_table.has_key($global_option)) {
				$default = $defaults_table[$global_option]
			} else {
				$default = undef
			}
			if ($value == undef and $default != undef) {
				$context.explain || { "Found value for ${global_option} in 'profiles::options_defaults'"}
				$retval = $default
			} else {
				$context.explain || { "Set value for ${key} to value of ${global_option}"}
				$retval = $value
			}
		} else {
			$retval = undef
		}
	} else {
		$retval = undef
	}
	if ($retval == undef) {
		$context.not_found
	} else {
		$retval
	}
}
