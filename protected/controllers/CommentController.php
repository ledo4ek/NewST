<?php

class CommentController extends Controller
{

	/**
	 * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	 * using two-column layout. See 'protected/views/layouts/column2.php'.
	 */
	public $layout = '//layouts/column2';

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 */
	private $_model;

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
	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
	public function accessRules()
	{
		return array(
			array ('allow', // allow all users to perform 'list' and 'view' actions
				'actions' => array('view'), 'users' => array('*'),
			),
			array ('allow', // allow authenticated user to perform any action
				'actions' => array('update', 'delete', 'create', 'vote'), 'users' => array('@'),
			),
			array ('allow', // allow authenticated user to perform any action
				'actions' => array('admin', 'approve'), 'roles' => array('administrator', 'moderator'),), array(
				'deny', // deny all users
				'users' => array('*'),
			),
		);
	}

	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionView($id)
	{
		$this->render('view', array('model' => $this->loadModel($id),));
	}

	/**
	 * Method Post
	/*/

	public function actionCreate()
	{
		$comment = new Comment;

		// TODO Сделать валидацию на стороне клиента

		if (isset($_POST['Comment']))
		{
			$comment->attributes = $_POST['Comment'];
			$comment->save();
		}

		echo json_encode($comment);
		Yii::app()->end();
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($id)
	{
		$model = Comment::model()->findByPk($id);

		if ($model->hasAccess())
		{
			$this->performAjaxValidation($model);

			if (isset($_POST['Comment']))
			{
				$model->attributes = $_POST['Comment'];
				if ($model->save())
				{
					if(User::model()->hasFullAccess())
						$this->redirect(array('admin'));

					$this->redirect($model->getUrl());
				}
			}

			$this->render('update', array(
				'model' => $model,));
		}
		else
			throw new CHttpException(404, 'Запрашиваемая страница не существует.');
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */

	public function actionDelete($id)
	{
		$model = $this->loadModel($id);

		if ($model && !Yii::app()->request->isPostRequest && $model->hasAccess())
		{
			if (Yii::app()->request->isAjaxRequest)
			{
				$data = array('id' => $id, 'countComments' => $model->post->commentCount - 1);
			}

			$model->delete();
		}

		if (!Yii::app()->request->isAjaxRequest)
			$this->redirect($model->post->getUrl() . "#comments");

		echo json_encode($data);
		Yii::app()->end();
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		if (User::model()->hasFullAccess())
		{
			$model = new Comment('search');
			$model->unsetAttributes(); // clear any default values
			// Лучше всегда для таких целей POST использовать
			if (isset($_GET['Comment']))
				$model->attributes = $_GET['Comment'];

			$this->render('admin', array(
				'model' => $model,));
		}
		else
			throw new CHttpException(404, 'Запрашиваемая страница не существует.');

	}

	// Не понял, зачем модель кэшировать
	public function loadModel($id)
	{
		if ($this->_model === null)
		{
			if (isset($id))
			{
				if (Yii::app()->user->isGuest)
					$condition = 'status=' . Comment::STATUS_PUBLISHED;
				else
					$condition = '';
				$this->_model = Comment::model()->findByPk($id, $condition);
			}
			if ($this->_model === null)
				throw new CHttpException(404, 'Запрашиваемая страница не существует.');
		}
		return $this->_model;
	}


	public function actionVote()
	{
		$id = $_POST['id'];
		$vote = $_POST['vote'];

		$comment = Comment::model()->findByPk($id);

		if (Yii::app()->request->isPostRequest && $comment && ($vote === Vote::VALUE_PLUS || $vote === Vote::VALUE_MINUS))
		{
			if ($comment->canVote())
			{
				$model = new Vote;
				$model->comment_id = $id;
				$model->author_id = Yii::app()->user->id;
				$model->value = $vote === Vote::VALUE_PLUS ? 1 : -1;

				$model->save();
			}
		}
		else   // TODO возможна ли такая ситуация?
			throw new CHttpException(404, 'Запрашиваемая страница не существует.');

	}

	/**
	 * Performs the AJAX validation.
	 * @param CModel the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if (isset($_POST['ajax']) && $_POST['ajax'] === 'comment-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}

}
