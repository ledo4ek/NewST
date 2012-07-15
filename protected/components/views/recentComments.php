<ul>
   <?php foreach ($this->getRecentComments() as $comment): ?>
   <li>
	  <?php echo CHtml::link($comment->author->username, $comment->author->getUrl())  ?> в теме
	  <?php echo CHtml::link(Chtml::encode($comment->post->title), $comment->post->getUrl()) ?>
   </li>
   <?php endforeach ?>
</ul>