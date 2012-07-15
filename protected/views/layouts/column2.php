<?php $this->beginContent('//layouts/main'); ?>
<div id="content">
   <?php echo $content; ?>
</div>
<div id="right">
   <!-- content -->
   <div class="sidebar">
	  <?php
	  $this->beginWidget('zii.widgets.CPortlet', array(
			'title' => 'Operations',
		 ));
	  $this->endWidget();
	  ?>
   </div>
   <!-- sidebar -->
   <div class="sidebar">
	  <?php
	  if (!Yii::app()->user->isGuest)
		 $this->widget('UserMenu');
	  ?>

	  <?php
	  $this->widget('TagCloud', array(
		 'maxTags' => 20,
	  ));
	  ?>

	  <?php $this->widget('RecentComments', array('maxComments' => 10,)); ?>


   </div>
</div>
</div>
<?php $this->endContent(); ?>