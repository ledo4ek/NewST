<div class="post">
   <div class="title"><h2><?php echo CHtml::encode($data->title) ?></h2></div>

   <div class="edit">
	  <?php if ($data->hasAccess()): ?>
	  <?php echo CHtml::link('', $data->getDeleteUrl(), array('class' => 'delete', 'onclick' => 'return confirm("Вы уверены?")')) ?>
	  <?php echo CHtml::link('', $data->getUpdateUrl(), array('class' => 'update')) ?>
	  <?php endif; ?>
   </div>

   <div class="content">
	  <?php $this->beginWidget('CHtmlPurifier'); ?>
	  <?php // TODO сделать обработку через модель и обработку одной большой строки ?>
	  <?php echo CStringHelper::trimContent($data->content) ?>
	  <?php $this->endWidget(); ?>
   </div>


   <div class="buttons">
	  <?php echo CHtml::link('Читать дальше', $data->getUrl(), array('class' => 'button')); ?>
   </div>

   <ul class="tags">
	  <?php if ($data->tags == null): ?>
		<?php echo 'Нет тегов' ?>
	  <?php else: ?>
	  <?php echo CHtml::encode($data->tags); ?>
	  <?php endif; ?>
   </ul>

   <div class="infopanel">
	  <div class="author">
		 <?php echo CHtml::link($data->author->username, $data->author->getUrl()); ?>
	  </div>
	  <div class="published">
		 <?php echo CDateHelper::formateDate($data->create_time); ?>
	  </div>

	  <div class="count_comments">
		 <?php echo CHtml::encode($data->commentCount); ?>
	  </div>
   </div>


</div>
