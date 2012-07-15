<?php
class WebUser extends CWebUser
{
	private $_model = null;

	function getRole()
	{
		if ($user = $this->getModel())
			return $user->role->access;
	}

	/**
	 * @return User - и полезно, и автодополнение будет лучше работать
	 */
	public function getModel()
	{
		if (!$this->isGuest && $this->_model === null) {
			$this->_model = User::model()->findByPk($this->id);
		}

		return $this->_model;

	}


}