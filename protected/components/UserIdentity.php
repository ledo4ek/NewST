<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class UserIdentity extends CUserIdentity
{
	private $_id;

	public function authenticate()
	{
		// Хотя LOWER и рекомендуют в примерах, но в большинстве случаев так только снижаем производительность.
		// Если у таблицы Collation utf8_general_ci то при сравнении строк все-равно регистр игнорируется
		$user = User::model()->find('LOWER(username)=?', array(strtolower($this->username)));

		if ($user === null)
			$this->errorCode = self::ERROR_USERNAME_INVALID;
		else if (!$user->validatePassword($this->password))
			$this->errorCode = self::ERROR_PASSWORD_INVALID;
		else
		{
			$this->_id = $user->id;
			$this->username = $user->username;
			$this->errorCode = self::ERROR_NONE;
		}
		return $this->errorCode == self::ERROR_NONE;
	}

	public function getId()
	{
		return $this->_id;
	}
}