<?php
$this->breadcrumbs=array(
	'Comments'=>array('index'),
	'Create',
);

?>

<h1>Create Comment</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>