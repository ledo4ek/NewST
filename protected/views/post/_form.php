<?php

/**
 * @var CActiveForm $form
 * @var Post $model

 */

?>
<div class="form">

   <?php
   $form = $this->beginWidget('CActiveForm', array(
	  'id' => 'post-form', 'enableAjaxValidation' => true,));
   ?>

   <?php
   $this->widget('ext.imperavi-redactor-widget.ImperaviRedactorWidget', array(
	  'selector' => '.redactor', 'options' => array(
		 'lang' => 'ru', 'css' => 'wym.css'),))
   ?>

   <?php // <p class="note">Поля с пометкой <span class="required">*</span> являются обязательными для заполнения.</p> ?>

   <?php //echo $form->errorSummary($model);  ?>

   <div class="row">
	  <?php echo $form->labelEx($model, 'title'); ?>
	  <?php echo $form->textField($model, 'title', array('size' => 91, 'maxlength' => 128)); ?>
	  <?php echo $form->error($model, 'title'); ?>
   </div>

   <div class="row">
	  <?php echo $form->labelEx($model, 'content'); ?>
	  <?php echo $form->textArea($model, 'content', array('rows' => 20, 'cols' => 70, 'class' => 'redactor')); ?>
	  <?php echo $form->error($model, 'content'); ?>
   </div>

   <?php if (!Yii::app()->user->isGuest): ?>
   <div class="row">
	  <?php echo $form->labelEx($model, 'tags'); ?>
	  <?php echo $form->textArea($model, 'tags', array('rows' => 2, 'cols' => 70)); ?>
	  <?php echo $form->error($model, 'tags'); ?>
   </div>
   <?php endif ?>


   <?php if (User::model()->hasFullAccess()): ?>
   <div class="row">
	  <?php echo $form->labelEx($model, 'status'); ?>
	  <?php echo $form->dropDownList($model, 'status', Lookup::items('PostStatus'), array('selected' => '2')); ?>
	  <?php echo $form->error($model, 'status'); ?>
   </div>
   <?php endif; ?>

   <div class="row buttons">
	  <?php echo CHtml::submitButton($model->isNewRecord ? 'Создать' : 'Изменить'); ?>
   </div>
   <?php $this->endWidget(); ?>

</div><!-- form -->