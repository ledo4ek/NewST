<?php

/**
 * This is the model class for table "{{post}}".
 *
 * The followings are the available columns in table '{{post}}':
 * @property integer $id
 * @property string $title
 * @property string $content
 * @property string $tags
 * @property integer $status
 * @property integer $create_time
 * @property integer $update_time
 * @property integer $author_id
 *
 * The followings are the available model relations:
 * @property Comment[] $comments
 * @property User $author
 */
class Post extends CActiveRecord
{

   const STATUS_DRAFT = 1;
   const STATUS_PUBLISHED = 2;
   const STATUS_ARCHIVED = 3;

   public static function model($className = __CLASS__)
   {

	  return parent::model($className);
   }

   public function tableName()
   {
	  return '{{post}}';
   }

   /**
	* @return array validation rules for model attributes.
	*/
   public function rules()
   {
	  return array(
		 array('title, content', 'required'),
		 array('title', 'length', 'max' => 128),
		 array('status', 'in', 'range' => array(1, 2, 3)),
		 // Нашел на форуме Yii эту регулярку и добавил \s|, для пробела и ,
		 array('tags', 'match', 'pattern' => '~^(\p{L}|\p{Zs}|\s|,)+$~u', 'message' => 'В тегах можно использовать только буквы.'),
		 array('tags', 'normalizeTags'),
		 array('title, status', 'safe', 'on' => 'search'),
	  );
   }

   /**
	* @return array relational rules.
	*/
   public function relations()
   {
	  return array(
		 'author' => array(self::BELONGS_TO, 'User', 'author_id'),
		  // Неправильная сортировка у 6.1 и 7 (519 и 509 комментарии), должны распологаться наоборот, сначала 7, затем 6.1, то есть по дате добавления
		 'comments' => array(self::HAS_MANY, 'Comment', 'post_id', 'order' => 'comments.path ASC, comments.id DESC'),
		 'commentCount' => array(self::STAT, 'Comment', 'post_id'),);
   }

   /**
	* @return array customized attribute labels (name=>label)
	*/
   public function attributeLabels()
   {
	  return array(
		 'id' => 'ID',
		 'title' => 'Заголовок',
		 'content' => 'Содержание',
		 'tags' => 'Теги',
		 'create_time' => 'Время создания',
		 'update_time' => 'Время обновления',
		 'author.username' => 'Author',
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
	  $criteria->compare('title', $this->title, true);
	  $criteria->compare('content', $this->content, true);
	  $criteria->compare('tags', $this->tags, true);
	  $criteria->compare('status', $this->status);
	  $criteria->compare('create_time', $this->create_time, true);
	  $criteria->compare('update_time', $this->update_time, true);
	  //$criteria->compare('author.username', $this->author->username);
	  return new CActiveDataProvider($this, array('criteria' => $criteria,));
   }

   public function normalizeTags($attribute, $params)
   {
	  $this->tags = Tag::array2string(array_unique(Tag::string2array($this->tags)));
   }

   protected function beforeSave()
   {
	  if (parent::beforeSave())
	  {
		 if ($this->isNewRecord)
		 {
			$this->author_id = Yii::app()->user->id;
			$this->status = self::STATUS_DRAFT;
		 }

		 return true;
	  }

	  return false;
   }

   private $_oldTags;

   protected function afterSave()
   {
	  parent:: afterSave();
	  Tag::model()->updateFrequency($this->_oldTags, $this->tags);
   }

   protected function afterDelete()
   {
	  parent::afterDelete();
	  Comment::model()->deleteAll('post_id=' . $this->id);
	  Tag::model()->updateFrequency($this->tags, '');
   }

   protected function afterFind()
   {
	  parent::afterFind();
	  $this->_oldTags = $this->tags;
   }

   /**
	* @return string
	*/
   public function getUrl()
   {
	  return Yii::app()->createUrl('post/view', array('id' => $this->id, 'title' => $this->title,));
   }

   /**
	* @return bool
	*/
   public function isUserPost()
   {
	  if (Yii::app()->user->checkAccess('user'))
		 return Yii::app()->user->id === $this->author_id;
	  return false;
   }

   /**
	* @return bool
	*/
   public function hasAccess()
   {
	  return User::model()->hasFullAccess() || $this->isUserPost();
   }

   /**
	* @return string
	*/
   public function getUpdateUrl()
   {
	  return Yii::app()->createUrl('post/update', array('id' => $this->id));
   }

   /**
	* @return string
	*/
   public function getDeleteUrl()
   {
	  return Yii::app()->createUrl('post/delete', array('id' => $this->id));
   }

}