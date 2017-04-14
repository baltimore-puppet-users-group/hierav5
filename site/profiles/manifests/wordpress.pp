class profiles::wordpress(
	$user = "root",
	$db_user = undef,
  $db_password = undef,
) {
	include mysql::server
	include apache
	include php
	include apache::mod::php
	class { "wordpress":
		install_dir => "/var/www/html",
		wp_owner    => $user,
		wp_group    => "root",
		db_user     => $db_user,
		db_password => $db_password,
	}
}
