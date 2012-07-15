<?php

class PostController extends Controller
{

   /**
	* @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	* using two-column layout. See 'protected/views/layouts/column2.php'.
	*/
   public $layout = '//layouts/column2';

   /**
	* @return array action filters
	*/
   public function filters()
   {
	  return array(
		 'accessControl', // perform access control for CRUD operations
	  );
   }

   /**
	* Specifies the access control rules.
	* This method is used by the 'accessControl' filter.
	* @return array access control rules
	*/
   public function accessRules()
   {
	  return array(
		 array(
			'allow', // allow all users to perform 'list' and 'view' actions
			'actions' => array('index', 'view'), 'users' => array('*'),), array(
			'allow', // allow authenticated user to perform any action
			'actions' => array('create', 'update', 'delete'), 'users' => array('@'),), array(
			'allow', // allow authenticated user to perform any action
			'actions' => array('admin'), 'roles' => array('administrator', 'moderator'),), array(
			'deny', // deny all users
			'users' => array('*'),),);
   }

   /**
	* Lists all models.
	*/
   public function actionIndex()
   {
	  $criteria = new CDbCriteria;
	  $criteria->addCondition('status=' . Post::STATUS_PUBLISHED);
	  $criteria->order = 'update_time DESC';
	  $criteria->with = 'commentCount';

	  if (isset($_GET['tag']))
		 $criteria->addSearchCondition('tags', $_GET['tag']);

	  $dataProvider = new CActiveDataProvider('Post', array(
		 'pagination' => array(
			'pageSize' => 5,), 'criteria' => $criteria,));

	  $this->render('index', array(
		 'dataProvider' => $dataProvider,));
   }

   private $_model;

   public function loadModel($id)
   {
	  if ($this->_model === null)
	  {
		 if (isset($id))
		 {
			if (Yii::app()->user->isGuest)
			   $condition = 'status=' . Post::STATUS_PUBLISHED . ' OR status=' . Post::STATUS_ARCHIVED;
			else
			   $condition = '';
			$this->_model = Post::model()->findByPk($id, $condition);
		 }
		 if ($this->_model === null)
			throw new CHttpException(404, 'Запрашиваемая страница не существует.');
	  }
	  return $this->_model;
   }

   public function actionView($id)
   {
	  $post = $this->loadModel($id);

	  $comment = new Comment();
	  $comment->post_id = $post->id;

	  $this->render('view', array(
		 'model' => $post, 'comment' => $comment));
   }

   /**
	* Manages all models.
	*/
   public function actionAdmin()
   {
	  if (User::model()->hasFullAccess())
	  {
		 $model = new Post('search');
		 $model->unsetAttributes(); // clear any default values
		 if (isset($_GET['Post']))
			$model->attributes = $_GET['Post'];

		 $this->render('admin', array(
			'model' => $model,));
	  }
	  else
		 throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
   }

   /**
	* Creates a new model.
	* If creation is successful, the browser will be redirected to the 'view' page.
	*/
   public function actionCreate()
   {
	  $model = new Post;

	  $this->performAjaxValidation($model);

	  if (isset($_POST['Post']))
	  {
		 $model->attributes = $_POST['Post'];
		 if ($model->save())
			$this->redirect(array(
			   'view', 'id' => $model->id));
	  }

	  $this->render('create', array(
		 'model' => $model,));
   }

   /**
	* Updates a particular model.
	* If update is successful, the browser will be redirected to the 'view' page.
	* @param integer $id the ID of the model to be updated
	*/
   public function actionUpdate($id)
   {
	  $model = $this->loadModel($id);

	  if ($model->hasAccess())
	  {
		 if (isset($_POST['ajax']) && $_POST['ajax'] === 'post-form')
		 {
			echo CActiveForm::validate($model);
			Yii::app()->end();
		 }

		 if (isset($_POST['Post']))
		 {
			$model->attributes = $_POST['Post'];

			if ($model->save())
			   $this->redirect($model->getUrl());
		 }

		 $this->render('update', array(
			'model' => $model,));
	  }
	  else
		 throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
   }


   /**
	* Deletes a particular model.
	* If deletion is successful, the browser will be redirected to the 'admin' page.
	* @param integer $id the ID of the model to be deleted
	*/
   public function actionDelete($id)
   {
	  $model = $this->loadModel($id);

	  if ($model && $model->hasAccess())
	  {
		 $this->loadModel($id)->delete();

		 if(User::model()->hasFullAccess())
			$this->redirect(array('admin'));

		 $this->redirect(array('post/index'));
	  }
	  else
		 throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
   }


   /**
	* Performs the AJAX validation.
	* @param CModel the model to be validated
	*/
   protected function performAjaxValidation($model)
   {
	  if (isset($_POST['ajax']) && $_POST['ajax'] === 'post-form')
	  {
		 echo CActiveForm::validate($model);
		 Yii::app()->end();
	  }
   }

}
