<?php
// Время по умолчанию
date_default_timezone_set("Asia/Yekaterinburg");

// change the following paths if necessary
$yii=dirname(__FILE__).'/../yii/framework/yii.php';
$config=dirname(__FILE__).'/protected/config/main.php';


$_SERVER['SERVER_NAME'] = isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : NULL;
switch ($_SERVER['SERVER_NAME']) {
	case 't1.l96.ru':
		$yii = dirname(__FILE__) . '/../renta/Source/yii/framework/yii.php';
		$config=dirname(__FILE__).'/protected/config/megahertz.php';
		break;
}


// remove the following lines when in production mode
defined('YII_DEBUG') or define('YII_DEBUG',true);
// specify how many levels of call stack should be shown in each log message
defined('YII_TRACE_LEVEL') or define('YII_TRACE_LEVEL',3);

require_once($yii);
Yii::createWebApplication($config)->run();

