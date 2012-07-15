<?php Yii::import('zii.widgets.CPortlet');

class UserMenu extends CPortlet
{
	public function init()
	{
		$this->title = $this->getTitle();
		parent::init();

	}

	protected function renderContent()
	{
		$this->render('userMenu');
	}

	// TODO изменить способ получения группы пользователя
	private function getTitle()
	{
		// По форматированию - или табы, или пробелы. Что-то одно
		return CHtml::encode(User::model()->getRole()->name) .
			' ' . CHtml::encode(Yii::app()->user->name);
	}
}