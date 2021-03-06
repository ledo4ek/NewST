<?php $this->beginContent('//layouts/main'); ?>
<div class="span-19">
    <div id="content">
        <?php echo $content; ?>
    </div><!-- content -->
</div>
<div class="span-5 last">
 <div id="sidebar">

<?php if(!Yii::app()->user->isGuest) $this->widget('UserMenu'); ?>
</div>

<?php $this ->widget('TagCloud',array(
    'maxTags'=>Yii::app()->params['tagCloudCount'],
)); ?>

<?php if(!Yii::app()->user->isGuest): ?>
<?php $this->widget('RecentComments',array(
        'maxComments'=>10, //Yii::app()->params['recentCommentCount'],
    )); ?>
<?php endif; ?>

<?php $this->endContent(); ?>
