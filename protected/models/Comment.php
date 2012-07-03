<?php

/**
 * This is the model class for table "{{comment}}".
 *
 * The followings are the available columns in table '{{comment}}':
 * @property integer $id
 * @property string $content
 * @property integer $status
 * @property string $create_time
 * @property string $author
 * @property string $email
 * @property string $url
 * @property integer $post_id
 */
class Comment extends CActiveRecord
{
    const STATUS_PENDING=1;
    const STATUS_APPROVED=2;
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Comment the static model class
	 */
	public static function model($className=__CLASS__)
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
            array('content, email', 'required'),
            array('author, email, url', 'length', 'max'=>128),
            array('email','email'),
            array('url','url'),
		//old
		/*return array(
			array('content, status, author, email, post_id', 'required'),
			array('status, post_id', 'numerical', 'integerOnly'=>true),
			array('author, email, url', 'length', 'max'=>128),
			array('create_time', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, content, status, create_time, author, email, url, post_id', 'safe', 'on'=>'search'), */
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
            'post' => array(self::BELONGS_TO, 'Post', 'post_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
            'id' => 'Id',
            'content' => 'Comment',
            'status' => 'Status',
            'create_time' => 'Create Time',
            'author' => 'Name',
            'email' => 'Email',
            'url' => 'Website',
            'post_id' => 'Post',
            //old
			/*'id' => 'ID',
			'content' => 'Content',
			'status' => 'Status',
			'create_time' => 'Create Time',
			'author' => 'Author',
			'email' => 'Email',
			'url' => 'Url',
			'post_id' => 'Post', */
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

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('content',$this->content,true);
		$criteria->compare('status',$this->status);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('author',$this->author,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('url',$this->url,true);
		$criteria->compare('post_id',$this->post_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

    protected function beforeSave()
    {
        $this->author = Yii::app()->user->name;
        if(parent::beforeSave())
        {


            if($this->isNewRecord)
                $this->create_time=time();
            return true;
        }
        else
            return false;
    }

    public function approve()
    {
        $this->status=Comment::STATUS_APPROVED;
        $this->update(array('status'));
    }

    public function getPendingCommentCount()
    {
        return $this->count('status='.self::STATUS_PENDING);
    }

    public function findRecentComments($limit=10)
    {
        return $this->with('post')->findAll(array(
            'condition'=>'t.status='.self::STATUS_APPROVED,
            'order'=>'t.create_time DESC',
            'limit'=>$limit,
        ));
    }

    public function getAuthorLink()
    {
        if(!empty($this->url))
            return CHtml::link(CHtml::encode($this->author),$this->url);
        else
            return CHtml::encode($this->author);
    }

    public function getUrl($post=null)
    {
        if($post===null)
            $post=$this->post;
        return $post->url.'#c'.$this->id;
    }
}