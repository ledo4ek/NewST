<?php

/**
 * This is the model class for table "{{vote}}".
 *
 * The followings are the available columns in table '{{vote}}':
 * @property integer $id
 * @property integer $comment_id
 * @property integer $author_id
 * @property integer $value
 *
 * The followings are the available model relations:
 * @property Comment $comment
 */
class Vote extends CActiveRecord
{
   // В иделае вообще константам назначить значение 1 и -1 и этими значениями везде оперировать
   const VALUE_PLUS  = 'plus';
   const VALUE_MINUS = 'minus';
   /**
	* Returns the static model of the specified AR class.
	* @param string $className active record class name.
	* @return Vote the static model class
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
	  return '{{vote}}';
   }

   /**
	* @return array validation rules for model attributes.
	*/
   public function rules()
   {
	  // NOTE: you should only define rules for those attributes that
	  // will receive user inputs.
	  return array(
	  );
   }

   /**
	* @return array relational rules.
	*/
   public function relations()
   {
	  return array(
		 array(
			'comment', self::BELONGS_TO, 'Comment', 'comment_id'
		 )
	  );
   }

   /**
	* @return array customized attribute labels (name=>label)
	*/
   public function attributeLabels()
   {
	  return array(
		 'id' => 'ID', 'comment_id' => 'Comment', 'author_id' => 'Author', 'value' => 'Value',
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
	  $criteria->compare('comment_id', $this->comment_id);
	  $criteria->compare('author_id', $this->author_id);
	  $criteria->compare('value', $this->value);

	  return new CActiveDataProvider($this, array(
		 'criteria' => $criteria,
	  ));
   }
/**
   protected function beforeSave()
   {
	  if (parent::beforeSave())
	  {
		 if ($this->isNewRecord)
		 {
			$this->author_id = Yii::app()->user->id;
			return true;
		 }
	  }
	  return false;
   }
 * */
}