<?php

/**
 * This is the model class for table "{{user}}".
 *
 * The followings are the available columns in table '{{user}}':
 * @property integer $id
 * @property string $username
 * @property string $password
 * @property string $email
 * @property string $salt
 * @property string $profile
 * @property integer $role_id
 * The followings are the available model relations:
 *
 * @property object $posts
 * @property object $comments
 * @property integer $countComments
 * @property integer $countPosts
 * @property object $role
 */

class User extends CActiveRecord
{
   const ROLE_ADMIN = 'administrator';
   const ROLE_MODER = 'moderator';
   const ROLE_USER = 'user';
   const ROLE_BANNED = 'banned';

   public static function model($className = __CLASS__)
   {
	  return parent::model($className);
   }

   /**
	* @return string the associated database table name
	*/
   public function tableName()
   {
	  return '{{user}}';
   }

   /**
	* @return array validation rules for model attributes.
	*/
   public function rules()
   {
	  // NOTE: you should only define rules for those attributes that
	  // will receive user inputs.
	  return array(
		 array(
			'username, password, email', 'required'
		 ), array(
			'username, password, email', 'length', 'max' => 128,
		 ), array(
			'profile', 'safe'
		 ), // The following rule is used by search().
		 // Please remove those attributes that should not be searched.
		 array(
			'id, username, email, profile', 'safe', 'on' => 'search'
		 ),
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
		'posts'          => array(self::HAS_MANY,   'Post',    'author_id'),
		 'comments'      => array(self::HAS_MANY,   'Comment', 'author_id'),
		 'countComments' => array(self::STAT,       'Comment', 'author_id'),
		 'countPosts'    => array(self::STAT,       'Post',    'author_id'),
		 'role'          => array(self::BELONGS_TO, 'Role',    'role_id'),
	  );
   }

   /**
	* @return array customized attribute labels (name=>label)
	*/
   public function attributeLabels()
   {
	  return array(
		 'id' => 'ID',
		 'username' => 'Username',
		 'password' => 'Password',
		 'email' => 'Email',
		 'salt' => 'Salt',
		 'profile' => 'Profile',
		 'role_id' => 'role_id',
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
	  $criteria->compare('username', $this->username, true);
	  $criteria->compare('password', $this->password, true);
	  $criteria->compare('email', $this->email, true);
	  $criteria->compare('salt', $this->salt, true);
	  $criteria->compare('profile', $this->profile, true);
	  //$criteria->compare('role_id', $this->role_id);

	  return new CActiveDataProvider($this, array(
		 'criteria' => $criteria,
	  ));
   }

   protected function beforeSave()
   {
	  if (parent::beforeSave())
	  {
		 // Не получится ли так, что при редактировании профиля зером/админом пароль повторно захэшируется?
		 $this->salt = self::generateSalt();
		 $this->password = self::hashPassword($this->password, $this->salt);
		 $this->role_id = self::ROLE_USER;

		 return true;
	  }

	  return false;
   }

   /**
	* @param $password
	* @param $salt
	* @return string
	*/
   public function hashPassword($password, $salt)
   {
	  return md5($salt . $password);
   }

   /**
	* @return string
	*/
   public function getUrl()
   {
	  return Yii::app()->createUrl('user/index', array('id' => $this->username,));
   }

   /**
	* @param $password
	* @return bool
	*/
   public function validatePassword($password)
   {
	  return $this->hashPassword($password, $this->salt) == $this->password;
   }

   /**
	* @return string
	*/
   public function generateSalt()
   {
	  return uniqid('' . true);
   }

   /**
	* @return mixed
	*/
   public function getRole()
   {
	  return $this->findByAttributes(array('username' => Yii::app()->user->name))->role;
   }

   /**
	* @return bool
	*/
   public function isAdmin()
   {
	  if(Yii::app()->user->checkAccess(self::ROLE_ADMIN))
		 return true;
	  return false;
   }

   /**
	* @return bool
	*/
   public function isModerator()
   {
	  if(Yii::app()->user->checkAccess(self::ROLE_MODER))
		 return true;
	  return false;
   }

   /**
	* @return bool
	*/
   public function hasFullAccess()
   {
	  return $this->isAdmin() || $this->isModerator();
   }


}