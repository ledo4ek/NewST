<div class="form">

   <?php
   $form = $this->beginWidget('CActiveForm', array(
	  'id' => 'user-form',
	  'enableAjaxValidation' => true,
   ));
   ?>

   <p class="note">Поля с пометкой <span class="required">*</span> обязательны для заполнения.</p>

   <?php //echo $form->errorSummary($model);  ?>

   <div class="row">
	  <?php echo $form->labelEx($model, 'username'); ?>
	  <?php echo $form->textField($model, 'username'); ?>
	  <?php echo $form->error($model, 'username'); ?>
   </div>

   <div class="row">
	  <?php echo $form->labelEx($model, 'password'); ?>
	  <?php echo $form->passwordField($model, 'password'); ?>
	  <?php echo $form->error($model, 'password'); ?>
   </div>

   <div class="row">
	  <?php echo $form->labelEx($model, 'email'); ?>
	  <?php echo $form->textField($model, 'email'); ?>
	  <?php echo $form->error($model, 'email'); ?>
   </div>

   <div class="row buttons">
	  <?php echo CHtml::submitButton('Register'); ?>
   </div>

   <?php $this->endWidget(); ?>

</div><!-- form -->