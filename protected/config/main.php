<?php

return array(

   'basePath' => dirname(__FILE__) . DIRECTORY_SEPARATOR . '..', 'name' => 'My Web Application',

   // preloading 'log' component
   'preload' => array('log'),

   'defaultController'=>'post',


   // autoloading model and component classes
   'import' => array(
	  'application.models.*', 'application.components.*', 'application.helpers.*',
   ),

   'modules' => array(
	  'gii' => array(
		 'class' => 'system.gii.GiiModule',
		 'password' => 'root',
		 // If removed, Gii defaults to localhost only. Edit carefully to taste.
		 'ipFilters' => array('127.0.0.1', '::1'),
	  ),

   ),

   // application components
   'components' => array(
	  'user' => array(
		 'class' => 'WebUser', // enable cookie-based authentication
		 'allowAutoLogin' => true,
	  ), // uncomment the following to enable URLs in path-format
	  /*
			'urlManager'=>array(
				'urlFormat'=>'path',
				'rules'=>array(
					'<controller:\w+>/<id:\d+>'=>'<controller>/view',
					'<controller:\w+>/<action:\w+>/<id:\d+>'=>'<controller>/<action>',
					'<controller:\w+>/<action:\w+>'=>'<controller>/<action>',
				),
			),
			*/
	  'db' => array(
		 'connectionString' => 'mysql:host=localhost;dbname=blog',
		 'emulatePrepare' => true,
		 'username' => 'root',
		 'password' => '1234',
		 'charset' => 'utf8',
		 'tablePrefix' => 'tbl_',
		 'enableParamLogging' => true,
		 'enableProfiling' => true,
	  ), 'errorHandler' => array(
		 'errorAction' => 'site/error',

	  ), /**
	  'log' => array(
	  'class' => 'CLogRouter', 'routes' => array(
	  array(
	  'class' => 'CFileLogRoute', 'levels' => 'error, warning',
	  ),



	  ),
	  ),
	   */
	  'log' => array(
		 'class' => 'CLogRouter', 'enabled' => YII_DEBUG, 'routes' => array(
			#...
			array(
			   'class' => 'CFileLogRoute', 'levels' => 'error, warning',
			),
			array(
			   'class' => 'application.extensions.yii-debug-toolbar.YiiDebugToolbarRoute',
			   'ipFilters' => array('127.0.0.1', '192.168.1.215', '217.76.184.153'),
			),
			/**
			array(
			'class' => 'CWebLogRoute',
			),*/
		 ),
	  ),


	  'authManager' => array(
		 'class' => 'PhpAuthManager',
		 'defaultRoles' => array('guest'),

	  ),
   ),

   // application-level parameters that can be accessed
   // using Yii::app()->params['paramName']
   'params' => array(
	  // this is used in contact page
	  'adminEmail' => 'webmaster@example.com',
   ),
   'language' => 'ru',
);