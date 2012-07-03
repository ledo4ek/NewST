<?php if(!empty($_GET['tag'])): ?>
<h1>Записи с тегом <i><?php echo CHtml::encode($_GET['tag']); ?></i></h1>
<?php endif; ?>

<?php $this->widget('zii.widgets.CListView', array(
    'dataProvider'=>$dataProvider,
    'itemView'=>'_view',
    'template'=>"{items}\n{pager}",
));
echo CHtml::link('Перейти на главную страницу',array('/'.Yii::app()->defaultController));
?>
