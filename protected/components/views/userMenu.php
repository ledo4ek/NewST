<ul>
	<li><?php echo CHtml::link('Создать новую запись', array('post/create')) ?></li>

   <?php if(User::model()->hasFullAccess()): ?>
	<li><?php echo CHtml::link('Управление записями', array('post/admin')) ?></li>
	<li><?php echo CHtml::link('Управление комментариями', array('comment/admin')) ?></li>
   <?php endif; ?>

	<li><?php echo CHtml::link('Выход', array('site/logout')) ?></li>
</ul>