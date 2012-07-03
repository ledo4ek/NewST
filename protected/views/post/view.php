<?php
$this->breadcrumbs=array(
	$model->title,
);
$this->pageTitle=$model->title;
?>

<div class="view">
<?php //echo CHtml::encode($data->title);
    echo CHtml::link(CHtml::encode($model->title), array('view', 'id'=>$model->id));
?>
	<br />
<?php echo Chtml::image($model->image); ?>
<br />

<?php echo CHtml::encode($model->content); ?>
<br />

<?php echo CHtml::encode($model->tags); ?>
<br />

<?php echo date('d-m-Y H:i:s',$model->create_time); ?>
<br />

<?php echo date('d-m-Y H:i:s',$model->update_time); ?>
<br />
</div>

<div id="comments">
	<?php if($model->commentCount>=1): ?>
		<h3>
			<?php echo $model->commentCount>1 ? $model->commentCount . ' comments' : 'One comment'; ?>
		</h3>

		<?php $this->renderPartial('_comments',array(
			'post'=>$model,
			'comments'=>$model->comments,
		)); ?>
	<?php endif; ?>

	<h3>Leave a Comment</h3>

	<?php if(Yii::app()->user->hasFlash('commentSubmitted')): ?>
		<div class="flash-success">
			<?php echo Yii::app()->user->getFlash('commentSubmitted'); ?>
		</div>
	<?php else: ?>
		<?php $this->renderPartial('/comment/_form',array(
			'model'=>$comment,
		)); ?>
	<?php endif; ?>


</div><!-- comments -->
