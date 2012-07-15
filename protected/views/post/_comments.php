<?php foreach ($comments as $comment): ?>
<?php //Решил сделать, как ты советовал, так лучше производительность и меньше запросов к БД ?>
<div class="comment_item_<?php echo $comment->getLevelComment()?>" id="comment_<?php echo $comment->id; ?>">
   <div class="info">
	  <?php echo CHtml::link($comment->author->username, $comment->author->getUrl(), array('class' => 'username')); ?>
	  <div class="datetime">
		 <?php echo CDateHelper::formateDate($comment->create_time) ?>
	  </div>
	  <?php echo CHtml::link('', $comment->getUrl(), array('class' => 'view')) ?>

	  <?php if ($comment->hasAccess()): ?>
	  <?php echo CHtml::link('', $comment->getUpdateUrl(), array('class' => 'update')) ?>
	  <?php echo CHtml::link('', '#', array('class' => 'delete')) ?>
	  <?php endif; ?>

	  <?php if (!Yii::app()->user->isGuest && !$comment->isUserComment()): ?>
	  <div class="<?php echo $comment->getUserVoteCss() ?>">
		 <?php echo CHtml::link('', '', array('class' => 'minus')) ?>
		 <?php echo CHtml::link('', '', array('class' => 'plus')) ?>
	  </div>
	  <?php endif; ?>

	  <?php // TODO Переделать ?>
	  <div class="<?php echo $comment->getCommentVotesCss()?>">
		 <?php echo $comment->getCommentVotes() ?>
	  </div>

   </div>
   <div class="content">
	  <?php // TODO обрезаются коды youtube ?>
	  <?php $this->beginWidget('CHtmlPurifier'); ?>
	  <?php echo $comment->content; ?>
	  <?php $this->endWidget(); ?>
   </div>
	<?php if (!Yii::app()->user->isGuest /*&& !$comment->isUserComment() */): ?>
   <?php  echo CHtml::link('Ответить', '#', array('class' => 'reply', 'id' => $comment->id)) ?>
	<?php endif; ?>
</div>

<?php endforeach; ?>
