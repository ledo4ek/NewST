<?php foreach($comments as $comment): ?>
   <div>
	  Комментарии:
	  <?php echo CHtml::link($comment->content, $comment->getUrl()); ?>
   </div>
	  <div>
	Автор комментария:
	<?php echo CHtml::link($comment->author->username, $comment->author->getUrl()); ?>
	Дата создания:
		 <?php	echo $comment->create_time;?>
	</div>

		 <br>
<?php endforeach; ?>