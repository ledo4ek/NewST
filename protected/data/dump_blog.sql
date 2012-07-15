-- 1) Лучше всегда использовать UNSINGED для числительных, если не предполагаются числа с имнусом.
-- Это особенно актуально для первичных ключей
--

-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Июл 03 2012 г., 12:14
-- Версия сервера: 5.5.16
-- Версия PHP: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `blog`
--

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_comment`
--

CREATE TABLE IF NOT EXISTS `tbl_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `status` int(11) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `path` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_comment_post` (`post_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=334 ;

--
-- Дамп данных таблицы `tbl_comment`
--

INSERT INTO `tbl_comment` (`id`, `content`, `status`, `create_time`, `author_id`, `post_id`, `path`) VALUES
(326, '1', 2, '2012-07-03 11:52:39', 1, 38, '1'),
(328, '2', 2, '2012-07-03 11:53:17', 3, 38, '2'),
(329, '2', 2, '2012-07-03 11:53:59', 5, 38, '3'),
(330, '3', 2, '2012-07-03 11:56:15', 2, 38, '4'),
(333, '3', 2, '2012-07-03 12:12:22', 5, 38, '7');

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_lookup`
--

CREATE TABLE IF NOT EXISTS `tbl_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `code` int(11) NOT NULL,
  `type` varchar(128) NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `tbl_lookup`
--

INSERT INTO `tbl_lookup` (`id`, `name`, `code`, `type`, `position`) VALUES
(1, 'Черновик', 1, 'PostStatus', 1),
(2, 'Опубликовано', 2, 'PostStatus', 2),
(3, 'Архив', 3, 'PostStatus', 3),
(4, 'На рассмотрении', 1, 'CommentStatus', 1),
(5, 'Одобрен', 2, 'CommentStatus', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_mp_tree`
--

CREATE TABLE IF NOT EXISTS `tbl_mp_tree` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `path` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpp_idx` (`path`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `tbl_mp_tree`
--

INSERT INTO `tbl_mp_tree` (`id`, `name`, `path`) VALUES
(1, 'FOOD', '1'),
(2, 'VEGETABLE', '1.1'),
(3, 'POTATO', '1.1.1'),
(4, 'TOMATO', '1.1.2'),
(5, 'FRUIT', '1.2'),
(6, 'APPLE', '1.2.1'),
(7, 'BANANA', '1.2.2');

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_post`
--
-- Добавить внешний ключ для author_id

CREATE TABLE IF NOT EXISTS `tbl_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `content` text NOT NULL,
  `tags` text,
  `status` int(11) NOT NULL, -- Лучше TINYINT(1) UNSIGNED NOT NULL DEFAUL 0 (не или не 0)
  `create_time` datetime DEFAULT NULL, -- Можешь использовать TIMESTAMP, тогда можно задавать create_time автоматически через CURRENT_TIMESTAMP
  `update_time` datetime DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_post_author` (`author_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

--
-- Дамп данных таблицы `tbl_post`
--

INSERT INTO `tbl_post` (`id`, `title`, `content`, `tags`, `status`, `create_time`, `update_time`, `author_id`) VALUES
(23, 'd', 'gf', '', 0, '2012-06-25 09:24:51', '2012-06-25 09:24:51', 3),
(24, 'Тест2', 'gfgf', 'gfgf', 0, '2012-06-25 09:25:08', '2012-06-25 09:25:08', 3),
(25, 'Тест1', 'gdfggfgfd', '', 0, '2012-06-25 11:25:01', '2012-06-25 11:25:01', 3),
(26, 'Соглашение внутри команды', 'dfsfdsfds', '', 0, '2012-06-25 12:52:08', '2012-06-25 12:52:08', 3),
(27, 'Тест2', '<p>dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232dsfddffdsf</p>\r\n\r\n<p>fdfdsfdsfdsfds21321321321232<span rel="pastemarkerend" id="pastemarkerend17352"></span></p>\r\n', '', 1, '2012-06-26 03:50:49', '2012-06-26 03:50:49', 1),
(32, 'dfsfdssf', '<p>dfsdfsf</p>\r\n', '', 1, '2012-06-26 09:59:36', '2012-06-26 09:59:36', 1),
(33, 'erter', '<p>ertreter</p>\r\n', '', 1, '2012-06-26 10:05:35', '2012-06-26 10:05:35', 1),
(34, 'Привет', '<p>ertreer</p>\r\n', '', 1, '2012-06-26 10:14:47', '2012-06-26 10:14:47', 1),
(35, '«Доска позора» с юзерами, выдающими приватную информацию', '<p><span style=" text-align: left; ">18-летний студент юрфака и PHP-разработчик Колум Хэйвуд (Callum Haywood) запустил настоящий социальный эксперимент на сайте&nbsp;</span><a href="http://www.weknowwhatyouredoing.com/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">We Know What You’re Doing</a><span style=" text-align: left; ">&nbsp;(«Мы знаем, что ты делаешь»). Сайт вытягивает информацию об отдельных пользователях через Facebook Graph API выкладывает её на всеобщее обозрение. Причём выкладывает не просто так, а с разбивкой по категориям: 1) список пользователей, которые «хотят, чтобы их уволили» с соответствующими цитатами из социальной сети; 2) список пользователей, которые находятся в похмелье с цитатами и фотографиями; 3) список тех, кто только что закурил марихуану или принял другой наркотик; 4) список пользователей, которые опубликовали свой новый номер телефона.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Выставляя юзеров на посмешище, то есть на всеобщее обозрение, основатель сервиса надеется привлечь внимание к проблеме утечки приватных данных через Facebook. Многие пользователи не задумываются о том, что их личная информация в реальности открыта всему миру, а их сообщения могут увидеть миллиарды жителей Земли. Своеобразная «доска почёта» привлекает внимание к таким пользователям, хотя здесь нет никакой секретной информации из подзамочных записей, всё это действительно лежит в открытом доступе на Facebook и доступно через простой GET-запрос типа</span><code style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(34, 34, 34); text-align: left; background-color: rgb(255, 255, 255); ">https://graph.facebook.com/search?q=hate%20my%20boss&amp;type=post&amp;locale=en_GB</code><span style=" text-align: left; ">, на что приходит ответ JSON-формате. На сайте просто происходит фильтрация полученной информации и обновление статусов с опозданием примерно на час.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Смысл «доски почёта» в том, что она показывает информацию, которую пользователи не хотели бы демонстрировать всем подряд, но на практике делают именно это. Может, таким способом людей удастся перевоспитать и они научатся пользоваться настройками приватности?</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Идея веб-сайта появилась из замечательной презентации Тома Скотта «</span><a href="http://www.tomscott.com/five/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">Я знаю, что ты сделал пять минут назад</a><span style=" text-align: left; ">».</span><br style=" text-align: left; "><br style=" text-align: left; "><iframe width="560" height="349" src="http://www.youtube.com/embed/cYVBshcN7wU" frameborder="0" allowfullscreen="" style="margin: 0px; padding: 0px; border-width: 0px; vertical-align: baseline; outline: 0px; text-align: left; "></iframe><span style=" text-align: left; ">&nbsp;</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Жаль, что на сайте нет колонки с теми пользователями Facebook, которые читают «Хабрахабр». Например, вот этот юзер:</span><br style=" text-align: left; "><a href="http://www.facebook.com/profile.php?=743264506" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">http://www.facebook.com/profile.php?=743264506</a>&nbsp;<span rel="pastemarkerend" id="pastemarkerend28447"></span><br>\r\n\r\n</p>\r\n', '', 2, '2012-06-27 10:04:50', '2012-06-27 10:04:50', 1),
(36, 'Соглашение внутри команды', '<p><img src="http://habrastorage.org/storage2/d03/113/bee/d03113bee5cf3bf91bc093e2c59ace87.png" style="margin: 0px; padding: 0px; border: 0px; vertical-align: middle; outline: 0px; max-width: 100%; text-align: left; " unselectable="on"><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">18-летний студент юрфака и PHP-разработчик Колум Хэйвуд (Callum Haywood) запустил настоящий социальный эксперимент на сайте&nbsp;</span><a href="http://www.weknowwhatyouredoing.com/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">We Know What You’re Doing</a><span style=" text-align: left; ">&nbsp;(«Мы знаем, что ты делаешь»). Сайт вытягивает информацию об отдельных пользователях через Facebook Graph API выкладывает её на всеобщее обозрение. Причём выкладывает не просто так, а с разбивкой по категориям: 1) список пользователей, которые «хотят, чтобы их уволили» с соответствующими цитатами из социальной сети; 2) список пользователей, которые находятся в похмелье с цитатами и фотографиями; 3) список тех, кто только что закурил марихуану или принял другой наркотик; 4) список пользователей, которые опубликовали свой новый номер телефона.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Выставляя юзеров на посмешище, то есть на всеобщее обозрение, основатель сервиса надеется привлечь внимание к проблеме утечки приватных данных через Facebook. Многие пользователи не задумываются о том, что их личная информация в реальности открыта всему миру, а их сообщения могут увидеть миллиарды жителей Земли. Своеобразная «доска почёта» привлекает внимание к таким пользователям, хотя здесь нет никакой секретной информации из подзамочных записей, всё это действительно лежит в открытом доступе на Facebook и доступно через простой GET-запрос типа</span><code style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(34, 34, 34); text-align: left; background-color: rgb(255, 255, 255); ">https://graph.facebook.com/search?q=hate%20my%20boss&amp;type=post&amp;locale=en_GB</code><span style=" text-align: left; ">, на что приходит ответ JSON-формате. На сайте просто происходит фильтрация полученной информации и обновление статусов с опозданием примерно на час.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Смысл «доски почёта» в том, что она показывает информацию, которую пользователи не хотели бы демонстрировать всем подряд, но на практике делают именно это. Может, таким способом людей удастся перевоспитать и они научатся пользоваться настройками приватности?</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Идея веб-сайта появилась из замечательной презентации Тома Скотта «</span><a href="http://www.tomscott.com/five/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">Я знаю, что ты сделал пять минут назад</a><span style=" text-align: left; ">».<br>\r\n</span><br style=" text-align: left; "><span style=" text-align: left; ">Жаль, что на сайте нет колонки с теми пользователями Facebook, которые читают «Хабрахабр». Например, вот этот юзер:</span><br style=" text-align: left; "><a href="http://www.facebook.com/profile.php?=743264506" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">http://www.facebook.com/profile.php?=743264506</a>&nbsp;<span rel="pastemarkerend" id="pastemarkerend56203"></span><br>\r\n\r\n</p>\r\n', '', 2, '2012-06-27 10:15:59', '2012-06-27 10:29:24', 1),
(38, 'Касперского не затроллишь!', '<p><span style=" text-align: left; ">Евгений Касперский опубликовал у себя в блоге&nbsp;</span><a href="http://eugene.kaspersky.ru/2012/06/26/kill-the-troll/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">пост</a><span style=" text-align: left; ">, где подробно рассказал о борьбе компании с&nbsp;</span><a href="http://ru.wikipedia.org/wiki/%D0%9F%D0%B0%D1%82%D0%B5%D0%BD%D1%82%D0%BD%D1%8B%D0%B9_%D1%82%D1%80%D0%BE%D0%BB%D0%BB%D1%8C" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">патентым троллем</a><span style=" text-align: left; ">.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Эпопея началась в 2008 году с решения не поддаваться на шантаж компании IPAT. По словам Касперского, его лаборатория была не единственной жертвой тролля, но единственной, что принципиально не принимала никаких предложений о «мирном» разрешении проблемы.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Другие производители антивирусов выплатили IPAT от нескольких десятков тысяч до нескольких миллионов долларов.</span><br style=" text-align: left; "><br style=" text-align: left; ">\r\n</p>\r\n\r\n<blockquote style="margin-top: 0.83em; margin-bottom: 0.83em; margin-left: 0px; padding: 0px 0px 0px 15px; border-width: 0px 0px 0px 2px; border-left-color: rgb(187, 187, 187); vertical-align: baseline; outline: 0px; quotes: none; clear: both; color: rgb(0, 0, 0); font-style: normal; text-align: left; ">Ну и началась та самая история, которая называется «американский патентный суд Штата Техас». Почему именно Техас – а поскольку троллей там любят, защищают и отстаивают их интересы. А за это тролли платят налоги этому самому штату Техас. Посему по всем признакам – вариант негативного развития событий для нас был весьма вероятным.</blockquote>\r\n\r\n<br style=" text-align: left; "><span style=" text-align: left; ">Тем не менее, компания выиграла дело, хотя ценой этой победы были $2,5млн., 3,5 года и бессчетное количество нервов.<span rel="pastemarkerend" id="pastemarkerend73059"></span></span><br style=" text-align: left; ">', 'Kill The Troll, IPAT', 2, '2012-06-29 09:47:20', '2012-06-29 09:49:08', 4);

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_role`
--

CREATE TABLE IF NOT EXISTS `tbl_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `access` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `tbl_role`
--

INSERT INTO `tbl_role` (`id`, `name`, `access`) VALUES
(1, 'Пользователь', 'user'),
(2, 'Модератор', 'moderator'),
(3, 'Администратор', 'administrator'),
(4, 'Забанен', 'banned');

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_tag`
--

CREATE TABLE IF NOT EXISTS `tbl_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `frequency` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Дамп данных таблицы `tbl_tag`
--

INSERT INTO `tbl_tag` (`id`, `name`, `frequency`) VALUES
(18, 'gfgf', 1),
(19, 'Kill The Troll', 1),
(20, 'IPAT', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_user`
--

CREATE TABLE IF NOT EXISTS `tbl_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL, -- Добавить индекс
  `password` varchar(128) NOT NULL, -- Достаточно 32 символов
  `email` varchar(128) NOT NULL,
  `salt` varchar(24) NOT NULL,
  `profile` mediumtext,
  `role_id` int(13) DEFAULT NULL, -- Добавить внешний ключ
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

--
-- Дамп данных таблицы `tbl_user`
--

INSERT INTO `tbl_user` (`id`, `username`, `password`, `email`, `salt`, `profile`, `role_id`) VALUES
(1, 'Admin', '73670db79032ed917e13298cecd826f6', 'admin@gmail.com', '4fdd8bbeac7042.65179760', NULL, 3),
(2, 'test2', 'd196e02fba8d61fa2603d0e617922f6d', 'test2@example.com', '4fdd8bbeac7196.61040399', NULL, 3),
(3, 'test3', '9bdf69b7d72a14d9113d97438c2d29e0', 'test3@example.com', '4fdd8bbeac7250.40298476', NULL, 1),
(4, 'test4', '6c6cb7b0a5c3a3ae3e8ef2989466d6f5', 'test4@example.com', '4fdd8bbeac7306.63974276', NULL, 1),
(5, 'test5', '782f8a0c91620f0b39692a2b7a864ecc', 'test5@example.com', '4fdd8bbeac73c2.05692817', NULL, 1),
(6, 'test6', '60d2ba86c3aa9ca93a53dee876a8a057', 'test6@example.com', '4fdd8bbeac74f6.18530700', NULL, 1),
(7, 'test7', '56e6e374ae6a61b909659cabefe32b95', 'test7@example.com', '4fdd8bbeac75c0.17234088', NULL, 1),
(35, 'test18', 'a283fefba73e0c270255aab69ded76a6', 'g@mail.ru', '14fe6aa88dbe24', NULL, 1),
(36, 'zzzzz', '60ce29cc906a311de6aca72e60c5518d', 'zzzzz@mail.ru', '14fe6ad8f75ef1', NULL, 1),
(37, 'dfsfdsf', 'dfsfds', 'dsfds', 'dfsfds', 'dfsfds', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_vote`
--

CREATE TABLE IF NOT EXISTS `tbl_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) NOT NULL, -- Добавить внешний ключ
  `author_id` int(11) NOT NULL, -- Добавить внешний ключ
  `value` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=72 ;

--
-- Дамп данных таблицы `tbl_vote`
--

INSERT INTO `tbl_vote` (`id`, `comment_id`, `author_id`, `value`) VALUES
(67, 168, 4, 1),
(68, 172, 4, -1),
(69, 326, 3, -1),
(70, 328, 2, 1),
(71, 328, 5, 1);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `tbl_comment`
--
ALTER TABLE `tbl_comment`
  ADD CONSTRAINT `FK_comment_post` FOREIGN KEY (`post_id`) REFERENCES `tbl_post` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tbl_post`
--
ALTER TABLE `tbl_post`
  ADD CONSTRAINT `FK_post_author` FOREIGN KEY (`author_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
