<?php if (!empty($_GET['tag'])) : ?>
<h1>Записи с тегом <b><?php CHtml::encode($_GET['tag']) ?></b></h1>
<?php endif; ?>

<?php $this->widget('zii.widgets.CListView', array(
    'dataProvider' => $dataProvider,
    'itemView' => '_view',
    'template' => '{items}{pager}',
));?>