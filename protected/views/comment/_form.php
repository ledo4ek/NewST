<?php
/**
 * @var CActiveForm $form
 * @var Comment $model
 */
?>

<div class="form">

	<?php // Пока оставил так ?>
	<?php if($model->isNewRecord): ?>
	<?php $form = $this->beginWidget('CActiveForm',array('id' => 'comment-form',
		'action' => Chtml::normalizeUrl(array('comment/create')))); ?>
	<?php else: ?>
	<?php $form = $this->beginWidget('CActiveForm', array('id' => 'comment-form')); ?>
	<?php endif; ?>

	<div class="row">
		<?php echo $form->textArea($model, 'content', array('rows' => 5, 'cols' => 50)); ?>
		<?php echo $form->error($model, 'content'); ?>
		<?php if($model->isNewRecord): ?>
		<?php echo $form->hiddenField($model, 'parent_id') ?>
		<?php echo $form->hiddenField($model, 'post_id') ?>
		<?php endif; ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Добавить' : 'Изменить'); ?>
	</div>
	<?php $this->endWidget(); ?>
</div><!-- form -->