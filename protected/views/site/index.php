<?php $this->pageTitle=Yii::app()->name; ?>

<h1>Blog'us <i><?php //echo CHtml::encode(Yii::app()->name); ?></i></h1>

<p></p>

<p>Blog'us - информационный сайт</p>

<?php
$posts=Post::model()->findAll();
//echo CHtml::encode($posts->title);
echo CHtml::link('главная',array('/'.Yii::app()->defaultController));
?>
<ul>
	<!-- <li>View file: <tt><?php echo __FILE__; ?></tt></li>
	<li>Layout file: <tt><?php echo $this->getLayoutFile('main'); ?></tt></li> -->
</ul>

<!--<p>For more details on how to further develop this application, please read
the <a href="http://www.yiiframework.com/doc/">documentation</a>.
Feel free to ask in the <a href="http://www.yiiframework.com/forum/">forum</a>,
should you have any questions.</p>-->

<h2></h2>