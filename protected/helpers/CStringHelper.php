<?php

class CStringHelper
{
   // Это не универсальный вариант, так что лучше через Yii::t
   public static function getCase($text, $count)
   {
	  if (strlen($count) > 2)
		 $count = substr($count, strlen($count) - 2);

	  if ($count > 30)
		 $count = 20 + substr($count, strlen($count) - 1);

	  switch (true)
	  {
		 case $count == 0:
			$end = 'иев';
			break;
		 case $count == 1:
			$end = 'ий';
			break;
		 case $count <= 4:
			$end = 'ия';
			break;
		 case $count <= 20:
			$end = 'иев';
			break;
		 case $count == 21:
			$end = 'ий';
			break;
		 case $count <= 24:
			$end = 'ия';
			break;
		 case $count <= 30:
			$end = 'иев';
	  }

	  return $text . $end;
   }

   public static function trimContent($text)
   {
	  $text_elements = explode('.', $text);

	  if (count($text_elements) > 5)
	  {
		 $text_elements = array_slice($text_elements, 0, 5);
		 $text = implode('.', $text_elements) . '';
	  }

	  return $text;
   }

}
