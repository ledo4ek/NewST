-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Июл 09 2012 г., 15:06
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
  `create_time` datetime DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `path` mediumtext,
  PRIMARY KEY (`id`),
  KEY `FK_comment_post` (`post_id`),
  KEY `FK_comment_author` (`author_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=632 ;

--
-- Дамп данных таблицы `tbl_comment`
--

INSERT INTO `tbl_comment` (`id`, `content`, `create_time`, `author_id`, `post_id`, `path`) VALUES
(499, '1', '2012-07-06 06:12:45', 3, 35, ''),
(500, '2', '2012-07-06 06:13:36', 3, 35, '499'),
(501, '3', '2012-07-06 06:13:57', 3, 35, '499.500'),
(504, '4', '2012-07-07 01:39:15', 3, 35, '499.500.502'),
(507, '5', '2012-07-07 01:42:13', 3, 35, '499.500.502.504'),
(508, '6', '2012-07-07 01:42:39', 3, 35, '499.500.502.504.507'),
(509, '7', '2012-07-07 01:48:05', 3, 35, '499.500.502.504.507.508'),
(510, '8', '2012-07-07 01:52:03', 3, 35, '499.500.502.504.507.508.509'),
(511, '9', '2012-07-07 01:52:19', 3, 35, '499.500.502.504.507.508.509.510'),
(512, '10', '2012-07-07 01:54:13', 3, 35, '499.500.502.504.507.508.509.510.511'),
(513, '11', '2012-07-07 01:54:36', 3, 35, '499.500.502.504.507.508.509.510.511.512'),
(514, '12', '2012-07-07 01:54:49', 3, 35, '499.500.502.504.507.508.509.510.511.512.513'),
(515, '13', '2012-07-07 01:55:05', 3, 35, '499.500.502.504.507.508.509.510.511.512.513.514'),
(516, '14', '2012-07-07 01:55:22', 3, 35, '499.500.502.504.507.508.509.510.511.512.513.514.515'),
(517, '15', '2012-07-07 01:55:40', 3, 35, '499.500.502.504.507.508.509.510.511.512.513.514.515.516'),
(518, '16', '2012-07-07 01:55:59', 3, 35, '499.500.502.504.507.508.509.510.511.512.513.514.515.516.517'),
(519, '6.1', '2012-07-07 01:56:20', 3, 35, '499.500.502.504.507.508'),
(520, '12.1', '2012-07-07 01:57:09', 3, 35, '499.500.502.504.507.508.509.510.511.512.513'),
(596, '1.1', '2012-07-09 11:27:58', 1, 35, '499'),
(630, '4', '2012-07-09 02:58:11', 1, 35, '499.596'),
(631, '55', '2012-07-09 02:59:16', 1, 35, '499.500.502.504.507.508.509.510.511.512.513.514.515.516.517.518');

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_lookup`
--

CREATE TABLE IF NOT EXISTS `tbl_lookup` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
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

CREATE TABLE IF NOT EXISTS `tbl_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `content` text NOT NULL,
  `tags` text,
  `status` tinyint(1) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_post_author` (`author_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=45 ;

--
-- Дамп данных таблицы `tbl_post`
--

INSERT INTO `tbl_post` (`id`, `title`, `content`, `tags`, `status`, `create_time`, `update_time`, `author_id`) VALUES
(35, '«Доска позора» с юзерами, выдающими приватную информацию', '<p><span style=" text-align: left; ">18-летний студент юрфака и PHP-разработчик Колум Хэйвуд (Callum Haywood) запустил настоящий социальный эксперимент на сайте&nbsp;</span><a href="http://www.weknowwhatyouredoing.com/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">We Know What You’re Doing</a><span style=" text-align: left; ">&nbsp;(«Мы знаем, что ты делаешь»). Сайт вытягивает информацию об отдельных пользователях через Facebook Graph API выкладывает её на всеобщее обозрение. Причём выкладывает не просто так, а с разбивкой по категориям: 1) список пользователей, которые «хотят, чтобы их уволили» с соответствующими цитатами из социальной сети; 2) список пользователей, которые находятся в похмелье с цитатами и фотографиями; 3) список тех, кто только что закурил марихуану или принял другой наркотик; 4) список пользователей, которые опубликовали свой новый номер телефона.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Выставляя юзеров на посмешище, то есть на всеобщее обозрение, основатель сервиса надеется привлечь внимание к проблеме утечки приватных данных через Facebook. Многие пользователи не задумываются о том, что их личная информация в реальности открыта всему миру, а их сообщения могут увидеть миллиарды жителей Земли. Своеобразная «доска почёта» привлекает внимание к таким пользователям, хотя здесь нет никакой секретной информации из подзамочных записей, всё это действительно лежит в открытом доступе на Facebook и доступно через простой GET-запрос типа</span><code style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(34, 34, 34); text-align: left; background-color: rgb(255, 255, 255); ">https://graph.facebook.com/search?q=hate%20my%20boss&amp;type=post&amp;locale=en_GB</code><span style=" text-align: left; ">, на что приходит ответ JSON-формате. На сайте просто происходит фильтрация полученной информации и обновление статусов с опозданием примерно на час.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Смысл «доски почёта» в том, что она показывает информацию, которую пользователи не хотели бы демонстрировать всем подряд, но на практике делают именно это. Может, таким способом людей удастся перевоспитать и они научатся пользоваться настройками приватности?</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Идея веб-сайта появилась из замечательной презентации Тома Скотта «</span><a href="http://www.tomscott.com/five/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">Я знаю, что ты сделал пять минут назад</a><span style=" text-align: left; ">».</span><br style=" text-align: left; "><br style=" text-align: left; "><iframe width="560" height="349" src="http://www.youtube.com/embed/cYVBshcN7wU" frameborder="0" allowfullscreen="" style="margin: 0px; padding: 0px; border-width: 0px; vertical-align: baseline; outline: 0px; text-align: left; "></iframe><span style=" text-align: left; ">&nbsp;</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Жаль, что на сайте нет колонки с теми пользователями Facebook, которые читают «Хабрахабр». Например, вот этот юзер:</span><br style=" text-align: left; "><a href="http://www.facebook.com/profile.php?=743264506" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">http://www.facebook.com/profile.php?=743264506</a>&nbsp;<span rel="pastemarkerend" id="pastemarkerend28447"></span><br>\r\n\r\n</p>\r\n', '', 2, '2012-06-27 10:04:50', '2012-07-07 02:33:29', 1),
(40, 'Соглашение внутри команды', '<p>2</p>\r\n', '', 2, '2012-07-07 02:06:01', '2012-07-07 02:06:01', 3),
(41, '1', '<p>2</p>\r\n', '', 1, '2012-07-07 03:03:23', '2012-07-07 03:40:12', 3),
(42, '2', '<p>1</p>\r\n', '', 2, '2012-07-07 03:42:49', '2012-07-07 03:43:02', 3),
(43, '2', '<p>1</p>\r\n', '', 1, '2012-07-07 03:43:44', '2012-07-07 03:43:58', 3),
(44, 'Соглашение внутри команды', '<p>1</p>\r\n', '', 1, '2012-07-07 03:49:46', '2012-07-07 03:50:25', 3);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_user`
--

CREATE TABLE IF NOT EXISTS `tbl_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(128) NOT NULL,
  `salt` varchar(24) NOT NULL,
  `profile` mediumtext,
  `role_id` int(13) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_author_role` (`role_id`),
  KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

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
(36, 'zzzzz', '60ce29cc906a311de6aca72e60c5518d', 'zzzzz@mail.ru', '14fe6ad8f75ef1', NULL, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `tbl_vote`
--

CREATE TABLE IF NOT EXISTS `tbl_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `value` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_vote_author` (`author_id`),
  KEY `FK_vote_comment` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `tbl_comment`
--
ALTER TABLE `tbl_comment`
  ADD CONSTRAINT `FK_comment_author` FOREIGN KEY (`author_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_comment_post` FOREIGN KEY (`post_id`) REFERENCES `tbl_post` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tbl_post`
--
ALTER TABLE `tbl_post`
  ADD CONSTRAINT `FK_post_author` FOREIGN KEY (`author_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD CONSTRAINT `FK_author_role` FOREIGN KEY (`role_id`) REFERENCES `tbl_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tbl_vote`
--
ALTER TABLE `tbl_vote`
  ADD CONSTRAINT `FK_vote_author` FOREIGN KEY (`author_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_vote_comment` FOREIGN KEY (`comment_id`) REFERENCES `tbl_comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
