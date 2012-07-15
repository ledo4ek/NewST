<?php
// Не рекомендую называть классы начиная с "C"
class CDateHelper
{
   // TODO посмотреть лучший способ форматирования даты
   public static function formateDate($date)
   {
	   $date = new DateTime($date);

	   // Позже сделаю, чтобы при создании пользователя задавалась его временная зона
	   $date->setTimezone(new DateTimeZone("Asia/Yekaterinburg"));
	   $date = $date->format('d m Y H:i');

	  // Лучше поэксперементировать с Yii::app()->dateFormatter->formatDateTime
	  $date_elements = explode(' ', $date);

	  $month = array(
		 '01' => 'января',
		 '02' => 'февраля',
		 '03' => 'марта',
		 '04' => 'апреля',
		 '05' => 'мая',
		 '06' => 'июня',
		 '07' => 'июля',
		 '08' => 'августа',
		 '09' => 'сентября',
		 '10' => 'октября',
		 '11' => 'ноября',
		 '12' => 'декабря',
	  );

	  $date_elements[1] = $month[$date_elements[1]];
	  $date_elements[2] .= ' в' ;

	  $date = implode(' ', $date_elements);
	  return $date;
   }

   public function newFormateDate($date)
   {
	  $date = date('d-m-Y H:i:s', $date);

   }
}