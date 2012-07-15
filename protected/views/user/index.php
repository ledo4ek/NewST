<h2><?php echo "Профиль пользователя " . CHtml::encode($user->username) ?></h2>

<?php // TODO Проверить правильность вывода и работу через контроллер ?>
<?php echo "Статус: " . Chtml::encode($user->role->name); ?>
<br/><br/>
<?php echo "Email: " . CHtml::encode($user->email); ?>
<br/><br/>
<?php echo CHtml::link("Посты" . "(" . CHtml::encode($user->countPosts) . ")", array(
   'posts' . '&id=' . $user->username,
)); ?>
<br>

<?php echo CHtml::link("Комментарии (" . CHtml::encode($user->countComments) . ")", array(
   'comments' . '&id=' . $user->username,
)); ?>

