<?php Yii::app()->clientScript->registerScriptFile(Yii::app()->request->getBaseUrl() . '/js/jquery.form.js') ?>
<?php Yii::app()->clientScript->registerScriptFile(Yii::app()->request->getBaseUrl() . '/js/ajax.send-comment-form.js') ?>

<div class="post">
	<div class="title"><h1><?php echo CHtml::encode($model->title)?></h1></div>

	<div class="edit">
		<?php if ($model->hasAccess()): ?>
		<?php echo CHtml::link('', $model->getDeleteUrl(), array('class' => 'delete', 'onclick' => 'return confirm("Вы уверены?")')) ?>
		<?php echo CHtml::link('', $model->getUpdateUrl(), array('class' => 'update')) ?>
		<?php endif; ?>
	</div>

	<div class="content">
		<?php $this->beginWidget('CHtmlPurifier'); ?>
		<?php echo $model->content; ?>
		<?php $this->endWidget(); ?>
	</div>

	<ul class="tags">
		<?php if ($model->tags == null): ?>
		<?php echo 'Нет тегов' ?>
		<?php else: ?>
		<?php echo CHtml::encode($model->tags); ?>
		<?php endif; ?>
	</ul>

	<div class="infopanel">
		<div class="author">
			<?php echo CHtml::link($model->author->username, $model->author->getUrl()); ?>
		</div>
		<div class="published">
			<?php echo CDateHelper::formateDate($model->create_time); ?>
		</div>

		<div class="count_comments">
			<?php echo CHtml::encode($model->commentCount); ?>
		</div>
	</div>
</div>

<?php if ($model->status == Post::STATUS_PUBLISHED): ?>
<div class="comments" id="comments">
	<?php if ($model->commentCount >= 1): ?>

	<h3>
		<?php echo Yii::t('app', '{n} комментарий|{n} комментария|{n} комментариев|{n} комментарий', $model->commentCount) ?>
	</h3>
	<?php $this->renderPartial('_comments', array('post' => $model, 'comments' => Comment::model()->commentSort($model->comments))); ?>

	<?php endif; ?>

	<div id="new_comment">
		<?php if (!Yii::app()->user->isGuest): ?>

		<?php if (Yii::app()->user->hasFlash('commentSubmitted')): ?>
			<div class="flash-success">
				<?php echo Yii::app()->user->getFlash('commentSubmitted'); ?>
			</div>
			<?php else: ?>
			<?php $this->renderPartial('/comment/_form', array('model' => $comment,)); ?>
			<?php endif; ?>

		<?php else: ?>
		<h4>Вы не авторизованы! <?php echo Chtml::link('Войти', Yii::app()->createUrl('site/login')) ?> или
			<?php echo Chtml::link('зарегистрироваться', Yii::app()->createUrl('user/register')) ?></h4>
		<?php endif; ?>
	</div>
</div>
<?php endif; ?>

<!--comments -->