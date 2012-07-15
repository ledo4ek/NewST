<h1>Просмотр комментария #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
   'data' => $model, 'attributes' => array(
	  'content', //'author',
	  'create_time',
   ),
)); ?>
