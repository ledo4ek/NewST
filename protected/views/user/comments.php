<h2><?php echo "Профиль пользователя " . CHtml::encode($user->username) ?></h2>
<h1>Комментарии</h1>
<div class="comments" id="comments">
<?php foreach ($user->comments as $comment): ?>
<div class="comment_item_1" id="comment_<?php echo $comment->id; ?>">
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
</div>
<?php endforeach; ?>
</div>