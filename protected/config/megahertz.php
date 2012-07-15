<?php
return CMap::mergeArray(require(dirname(__FILE__) . '/main.php'), array(
	'components' => array(
		'db' => array(
			'connectionString' => 'mysql:unix_socket=/var/run/mysqld/mysqld.sock;dbname=t1',
			'username' => 'root',
			'password' => getenv('DB_PASS'),
		),
	),
));