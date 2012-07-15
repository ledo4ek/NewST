<div class="comment_item" id="comment_<?php echo $data->id; ?>">
   <div class="info">
	  <?php echo CHtml::link($data->author->username, $data->author->getUrl(), array('class' => 'username')); ?>
	  <div class="datetime">
		 <?php echo CDateHelper::formateDate($data->create_time) ?>
	  </div>
	  <span class="view">
	  	<?php echo CHtml::link(Chtml::image("/blog/images/tools/view.png", "view"), "#comment_" . $data->id, array('class' => 'cid',)); ?>
	 </span>
	  <?php if ($data->hasAccess()): ?>
	  <span class="update">
		 <?php echo CHtml::link(Chtml::image("/blog/images/tools/update.png", "update"), $data->getUpdateUrl()) ?>
	  </span>
	  <span class="delete">
		 <?php echo CHtml::link(Chtml::image("/blog/images/tools/delete.png", "delete"), $data->getDeleteUrl(), array('onclick' => 'return confirm("Вы уверены?")')) ?>
	  </span>
	  <?php endif; ?>
   </div>

   <div class="content">
	  <?php // TODO CHtml::encode() ?>
	  <?php $this->beginWidget('CHtmlPurifier'); ?>
	  <?php echo $data->content; ?>
	  <?php $this->endWidget(); ?>
   </div>

   <? echo CHtml::checkBox('Selected[]', false, array('value' => $data->id))    ?>
</div>