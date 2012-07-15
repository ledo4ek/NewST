<?php

class UserController extends Controller
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
		 'accessControl',
		 // perform access control for CRUD operations
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
			'allow', // allow all users to perform 'index' and 'view' actions
			'actions' => array(
			   'index', 'posts', 'comments', 'register'
			), 'users' => array('*'),
		 ), array(
			'allow', // allow admin user to perform 'admin' and 'delete' actions
			'actions' => array(
			   'admin', 'delete'
			), 'users' => array('admin'),
		 ), array(
			'deny', // deny all users
			'users' => array('*'),
		 ),
	  );
   }

   /**
	* Lists all models.
	*/
   public function actionIndex($id)
   {
	  $user = $this->loadModel($id);
	  // Эту проверку нужно вынести в loadModel
	  if($user === null)
		 throw new CHttpException(404, 'Запрашиваемая страница не существует.');
	  $this->render('index', array('user' => $user));
   }

   public function actionComments($id)
   {
	  $user = $this->loadModel($id);
	  if($user === null)
		 throw new CHttpException(404, 'Запрашиваемая страница не существует.');
	  $this->render('comments', array('user' => $user));
   }

   public function actionPosts($id)
   {
	  $user = $this->loadModel($id);
	  if($user === null)
		 throw new CHttpException(404, 'Запрашиваемая страница не существует.');
	  $this->render('posts', array('user' => $user));
   }

   public function actionRegister()
   {
	  $model = new User;

	  $this->performAjaxValidation($model);

	  if (isset($_POST['User']))
	  {
		 $model->attributes = $_POST['User'];

		 // Нет назначения роли
		 if ($model->save())
		 {
			Yii::app()->user->setFlash('registerSuccess', 'Thank you for your registration. You may login now.');
			$this->redirect(Yii::app()->createUrl('site/login'));
		 }
	  }

	  $this->render('register', array(
		 'model' => $model,
	  ));
   }

   public function loadModel($id)
   {
	  return User::model()->with('comments')->together()->findByAttributes(array('username'=>$id));
   }

   /**
	* Performs the AJAX validation.
	* @param CModel the model to be validated
	*/
   protected function performAjaxValidation($model)
   {
	  if (isset($_POST['ajax']) && $_POST['ajax'] === 'user-form')
	  {
		 echo CActiveForm::validate($model);
		 Yii::app()->end();
	  }
   }
}
