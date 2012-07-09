<div class="view">
<h1>

	<?php //echo CHtml::encode($data->title);
    echo CHtml::link(CHtml::encode($data->title), array('view', 'id'=>$data->id));?>
	<br />
</h1>

    <?php echo Chtml::image($data->image,'',array('width' => '350', 'height' => '250','class' => 'imagetx')); ?>
    <br />

	<?php echo CHtml::encode(mb_substr($data->content,0,2020,"utf-8")); ?>
    <br />
    <br />
    <?php echo Chtml::link('Читать дальше->',Yii::app()->createUrl('post/view', array('id' => $data->id))); ?>
	<br />

	<?php echo CHtml::encode($data->tags); ?>
	<br />


	<?php echo 'Дата создания:';
   echo date('d-m-Y H:i:s',$data->create_time); ?>


	<?php echo 'Дата обновления:';
   echo date('d-m-Y H:i:s',$data->update_time); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('author_id')); ?>:</b>
	<?php echo CHtml::encode($data->author_id); ?>
	<br />

	*/ ?>

</div>