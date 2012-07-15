<?php

/**
 * This is the model class for table "{{comment}}".
 *
 * The followings are the available columns in table '{{comment}}':
 * @property integer $id
 * @property string $content
 * @property integer $status
 * @property integer $create_time
 * @property string $author_id
 * @property integer $post_id
 * @property string $path
 * @property integer $parent_id;
 *
 * The followings are the available model relations:
 * @property Post $post
 * @property User $author
 * @property Vote $sumVotes
 */
class Comment extends CActiveRecord
{

	const MAX_NESTING = 14;
	public $parent_id;

	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Comment the static model class
	 */
	public static function model($className = __CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return '{{comment}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('content, post_id', 'required'),
			array('author_id', 'default', 'value' => Yii::app()->user->id, 'setOnEmpty' => false),
			array('content, parent_id', 'length', 'max' => 700),
			array('parent_id', 'safe'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'post' => array(self::BELONGS_TO, 'Post', 'post_id', 'condition' => 'post.status =' . Post::STATUS_PUBLISHED),
			'author' => array(self:: BELONGS_TO, 'User', 'author_id'),
			'sumVotes' => array(self::STAT, 'Vote', 'comment_id', 'select' => 'SUM(value)'),
			'userVote' => array(self::HAS_ONE, 'Vote', 'comment_id', 'condition' => 'userVote.author_id=' . Yii::app()->user->id),/**
			'vote' => array(self::HAS_ONE, 'Vote', 'comment_id','condition' => 'vote.author_id=author_id','params' => array('author_id' => Yii::app()->user->id)), */
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'Id',
			'content' => 'Комментарий',
			'status' => 'Статус',
			'create_time' => 'Время создания',
			'author_id' => 'author_id',
			'post_id' => 'post_id',
			'author.username' => 'Автор:',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria = new CDbCriteria;
		$criteria->compare('id', $this->id);
		$criteria->compare('content', $this->content, true);
		$criteria->compare('create_time', $this->create_time, true);
		//$criteria->compare('post_id', $this->post_id, true);

		// TODO сделать нормальный поиск в виде
		$criteria->compare('author', $this->author);

		return new CActiveDataProvider($this, array('criteria' => $criteria,));
	}

	protected function beforeSave()
	{
		// Это делается через default validator и CTimestampBehavior
		if (parent::beforeSave())
		{
			if ($this->isNewRecord)
			{
				$this->path = $this->getCommentPath();
			}
			return true;
		}
		return false;
	}

	// Get URL for comment
	public function getUrl()
	{
		return Yii::app()->createUrl('post/view', array('id' => $this->post_id,)) . '#comment_' . $this->id;
	}

	public function getUpdateUrl()
	{
		return Yii::app()->createUrl("comment/update", array('id' => $this->id));
	}

	public function getDeleteUrl()
	{
		return Yii::app()->createUrl("comment/delete", array('id' => $this->id));
	}

	/**
	 * Ищет последние комментарии
	 * @param int $limit
	 * @return array
	 */
	public function findRecentComments($limit = 10)
	{
		return $this->with('post')->findAll(array('order' => 't.create_time DESC', 'limit' => $limit,));
	}

	/**
	 * Определяет, является ли данный комментарий комментарием пользователя
	 * @return bool
	 */
	public function isUserComment()
	{
		if (Yii::app()->user->checkAccess('user'))
			return Yii::app()->user->id === $this->author_id;
		return false;
	}

	/**
	 * Определяет, имеет ли пользователь доступ к опциям изменения комментария
	 * @return bool
	 */
	public function hasAccess()
	{
		return User::model()->hasFullAccess() || $this->isUserComment();
	}

	// TODO Переделать
	/**
	 * Возвращает результат, может ли пользователь голосовать за комментарий
	 * @return bool
	 */
	public function canVote()
	{
		if ($this->author_id != Yii::app()->user->id)
			return Vote::model()->findByAttributes(array('author_id' => Yii::app()->user->id, 'comment_id' => $this->id)) === null;
		else
			return false;
	}

	/**
	 * Возвращает ссылку для голосования за комментарий
	 * @param $param plus|minus
	 * @return string
	 */
	public function getVoteUrl($param)
	{
		if ($this->canVote())
			return Yii::app()->createUrl('comment/vote', array('id' => $this->id, 'vote' => $param));
		else
			return $this->getUrl();
	}

	/**
	 * Возвращает количество голосов за комментарий
	 * @return string|Vote
	 */
	public function getCommentVotes()
	{
		$votes = $this->sumVotes;
		return $votes > 0 ? '+' . $votes : $votes;
	}

	/**
	 * Возвращает CSS-класс для общего результата голосования за комментарий
	 * @return string
	 */
	public function getCommentVotesCss()
	{
		$votes = $this->getCommentVotes();

		if ($votes > 0)
			return 'mark-positive';
		elseif ($votes < 0)
			return 'mark-negative';
		else
			return 'mark-default';
	}

	/**
	 * Возвращает результат голосования за комментарий для текущего пользователя
	 * @return Vote->value | null
	 */
	public function getUserVote()
	{
		if (!Yii::app()->user->isGuest)
			return $this->userVote ? $this->userVote->value : null;
		else
			return null;
	}

	/**
	 * Возвращает CSS-класс для результата голосования за комментарий для пользователя
	 * @return string
	 */
	public function getUserVoteCss()
	{
		if (!$this->getUserVote())
			return 'voting';

		if ($this->getUserVote() == 1)
			return 'voted_plus';
		else
			return 'voted_minus';
	}

	/**
	 * Возвращает уровень комментария
	 * @return int
	 */
	public function getLevelComment()
	{
		if (!$this->path)
		{
			return 1;
		}
		else if (strpos($this->path, '.') === false)
		{
			return 2;
		}
		else
		{
			return substr_count($this->path, '.') + 2 > 14 ? 14 : substr_count($this->path, '.') + 2;
		}
	}

	/**
	 * Возвращает материлизованный путь до комментария
	 * @return null|string
	 */
	public function getCommentPath()
	{
		$reply = $this->parent_id;

		if ($reply && $reply != '')
		{
			// Решил у нового комментария записывать $reply в path, а потом его переназначать
			$parent = $this->findByAttributes(array('id' => $reply, 'post_id' => $this->post_id));

			if ($parent)
				if ($parent->path)
					return $parent->path . '.' . $reply;
				else
					return $reply;
		}
		return null;
	}

	/**
	 * @return string
	 */
	public function getUrlReply()
	{
		return Yii::app()->createUrl('post/view', array('id' => $this->post_id, 'reply' => $this->id));
	}

	public function commentSort($comments)
	{
		usort($comments, "self::cmp");
		return $comments;
	}

	function cmp($a, $b)
	{
		if($a->path)
			$a_path = 0 .'.'. $a->path . '.' . $a->id;
		else
			$a_path = 0 .'.'. $a->id;

		if($b->path)
			$b_path = 0 .'.'. $b->path . '.' . $b->id;
		else
			$b_path = 0 . '.' . $b->id;

		$res = strcmp($a_path, $b_path);

		return $res;
	}


}

