<?php

class UserIdentity extends CUserIdentity {
    // Будем хранить id.
    protected $_id;

    // Данный метод вызывается один раз при аутентификации пользователя.
    public function authenticate()
    {
        // Производим стандартную аутентификацию, описанную в руководстве.
        $user = User::model()->find('LOWER(username)=?', array(strtolower($this->username)));
        if($user===null)
            $this->errorCode=self::ERROR_USERNAME_INVALID;
        else if(!$user->validatePassword($this->password))
            $this->errorCode=self::ERROR_PASSWORD_INVALID;
           else {
            $this->_id = $user->id;
            $this->username = $user->username;

            $this->errorCode = self::ERROR_NONE;
        }
        return !$this->errorCode;
    }

    public function getId(){
        return $this->_id;
    }

}