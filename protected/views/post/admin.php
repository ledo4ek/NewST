<?php
$this->breadcrumbs = array(
	'Manage Posts',
);
?>
<h1>Manage Posts</h1>

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
	array(
		'name' => 'title',
		'type' => 'raw',
		'value' => 'CHtml::link(CHtml::encode($data->title), $data->url)'
	),
	array(
			'name' => 'status',
			'value' => 'Lookup::item("PostStatus",$data->status)',
			'filter' => Lookup::items('PostStatus'),
		),
		array(
			'name' => 'create_time',
			'value'=> 'date_format(date_create($data->create_time), "d-m-Y H:i:s")',
			'filter' => false,
		),
		array(
			'name' => 'update_time',
			'value'=> 'date_format(date_create($data->update_time), "d-m-Y H:i:s")',
			'filter' => false,
		),
	    array(
		  'name' => 'author.username',
		  'filter' => true
		),
		array(
			'class' => 'CButtonColumn',
		),
	),
)); ?>