-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Июл 10 2012 г., 20:03
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
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `author_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `path` mediumtext,
  PRIMARY KEY (`id`),
  KEY `FK_comment_post` (`post_id`),
  KEY `FK_comment_author` (`author_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=791 ;

--
-- Дамп данных таблицы `tbl_comment`
--

INSERT INTO `tbl_comment` (`id`, `content`, `create_time`, `author_id`, `post_id`, `path`) VALUES
(772, 'Хотел опубликовать, да кармы не хватало, рад что всё-таки запостили =)', '2012-07-10 17:41:11', 2, 46, NULL),
(773, 'Кстати парадокс, при отрицательной карме можно опубликовать статью в реканвери, а вот если у меня карма положительная, но её мало, то ты как в яме сидишь.', '2012-07-10 17:20:15', 1, 46, '772'),
(774, 'Идёшь в ближайший топик, пишешь: «Windows, Linux, Mac, Java, C#, PHP sucks!» — и проблема положительной кармы решена. Главное за -30 не вылететь…', '2012-07-10 17:41:11', 2, 46, '772.773'),
(775, 'Да не, тут по-моему проще и лучше будет, если тема общая с каким нибудь еще человеком и у него карма ниже 0.', '2012-07-10 17:20:35', 1, 46, '772.773.774'),
(776, 'вижу вашу проблему уже исправили )', '2012-07-10 17:41:11', 2, 46, '772.773.774.775'),
(777, 'Это вы про то, когда я раз в час писал? До сих пор осталась привычка большую часть в личку писать. Зато осознал полезность этого функционала и нашел баг.\r\nПисать можно раз в час, но если ты писал в лс это тоже учитывается. То есть отвечая в лс, я вообще терял возможность писать комментарии.', '2012-07-10 17:40:11', 3, 46, '772.773.774.775.776'),
(778, 'не обязательно писать что что-либо sux. Достаточно похвалить что-либо в неудачном месте ;)', '2012-07-10 17:21:05', 1, 46, '772.773.774.775'),
(779, 'Спасибо за новость, мог пропустить.\r\nДобавил свое «за».', '2012-07-10 17:40:11', 3, 46, NULL),
(780, 'Да ради б-га. 60% статей википедии содержат фактические ошибки', '2012-07-10 17:21:53', 1, 46, '779'),
(781, '77% статистики берётся с потолка.', '2012-07-10 17:40:11', 3, 46, '779.780'),
(782, 'нет 96%!', '2012-07-10 17:40:11', 3, 46, '779.780.781'),
(783, 'ага, туда же: «146%!!!1»', '2012-07-10 17:22:08', 1, 46, '779.780.781.782'),
(784, '«Целые числа и числа с плавающей точкой» и «Целые числа и с плавающей точкой» — одинаковы, может одно из них удалить?', '2012-07-10 17:36:26', 1, 47, NULL),
(785, 'О, точно. спасибо!', '2012-07-10 17:40:11', 3, 47, '784'),
(786, '| Набор из букв и цифр (латиница + кириллица):\r\n| ^[а-яА-Яa-zA-Z0-9]+$ \r\n\r\nНе верный шаблон т.к. не проглотит букву Ё:', '2012-07-10 17:37:01', 1, 47, NULL),
(787, 'Ага, так и есть, благодарю. ^[а-яА-ЯёЁa-zA-Z0-9]+$ — так ведь нормально?', '2012-07-10 17:37:22', 1, 47, '786'),
(788, 'Да.', '2012-07-10 17:40:11', 3, 47, '786.787'),
(789, 'Некоторые регулярки слабоваты — слишком тупо валидируют\r\nЕмаил: /^[-\\w.]+@([A-z0-9][-A-z0-9]+\\.)+[A-z]{2,4}$/\r\nURL: ~^(?:(?:https?|ftp|telnet)://(?:[a-z0-9_-]{1,32}". "(?::[a-z0-9_-]{1,32})?@)?)?(?:(?:[a-z0-9-]{1,128}\\.)+(?:com|net|". «org|mil|edu|arpa|gov|biz|info|aero|inc|name|[a-z]{2})|(?!0)(?:(?». "!0[^.]|255)[0-9]{1,3}\\.){3}(?!0|255)[0-9]{1,3})(?:/[a-z0-9.,_@%&". "?+=\\~/-]*)?(?:#[^ ''\\"&]*)?$~i', '2012-07-10 17:37:36', 1, 47, NULL),
(790, 'Email не проходит c символом +. Это довольно важная нотация, незаслуженно обходимая вниманием (можно тэги ставить или фильтры настраивать в гуглопочте, яндексе и т.п.)', '2012-07-10 17:40:11', 3, 47, '789');

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
-- Структура таблицы `tbl_post`
--

CREATE TABLE IF NOT EXISTS `tbl_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `content` text NOT NULL,
  `tags` text,
  `status` tinyint(1) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_post_author` (`author_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=48 ;

--
-- Дамп данных таблицы `tbl_post`
--

INSERT INTO `tbl_post` (`id`, `title`, `content`, `tags`, `status`, `create_time`, `update_time`, `author_id`) VALUES
(46, 'Русскоязычная Википедия готовится к забастовке', '<p><img src="http://habrastorage.org/storage2/b10/464/363/b1046436387fdece5b7c73dbbd377925.jpg" style="margin: 0px; padding: 0px; border: 0px; vertical-align: middle; outline: 0px; max-width: 100%; text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Завтра 10 июля 2012 года&nbsp;</span><a href="http://habrahabr.ru/post/147070/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">уже обсуждавшийся</a><span style=" text-align: left; ">&nbsp;</span><a href="http://ru.wikipedia.org/wiki/%D0%97%D0%B0%D0%BA%D0%BE%D0%BD%D0%BE%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82_%E2%84%96_89417-6" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">законопроект № 89417-6</a><span style=" text-align: left; ">&nbsp;предстоит обсудить депутатам&nbsp;</span><a href="http://ru.wikipedia.org/wiki/%D0%93%D0%BE%D1%81%D1%83%D0%B4%D0%B0%D1%80%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%B0%D1%8F_%D0%B4%D1%83%D0%BC%D0%B0" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">Госдумы</a><span style=" text-align: left; ">&nbsp;во втором чтении. Принятие этих норм угрожает напрямую многим мирным и полезным ресурсам, включая&nbsp;</span><a href="http://ru.wikipedia.org/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">Википедию</a><span style=" text-align: left; ">. И завтра же, вероятно, любой кто обратится к русскоязычному разделу этой электронной энциклопедии вместо ожидаемой информации увидит текст петиции, составленной редакторами.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Сегодня днём 9 июля 2012 года был инициирован&nbsp;</span><a href="http://ru.wikipedia.org/wiki/%D0%92%D0%B8%D0%BA%D0%B8%D0%BF%D0%B5%D0%B4%D0%B8%D1%8F:%D0%9E%D0%BF%D1%80%D0%BE%D1%81%D1%8B/%D0%97%D0%B0%D0%B1%D0%B0%D1%81%D1%82%D0%BE%D0%B2%D0%BA%D0%B0_%D0%BF%D1%80%D0%BE%D1%82%D0%B8%D0%B2_%D1%86%D0%B5%D0%BD%D0%B7%D1%83%D1%80%D1%8B_%D0%B2_%D0%A0%D1%83%D0%BD%D0%B5%D1%82%D0%B5" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">опрос</a><span style=" text-align: left; ">&nbsp;среди зарегистрированных редакторов ru.wikipedia, который должен закончится в половину двенадцатого ночи. Судя по динамике обсуждения, инициатива о перенаправлении со страниц проекта на специальное информационное сообщение с 00:00 вторника по 00:00 среды будет поддержана сообществом.&nbsp;</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Аналогичным способом привлекали внимание к вопросам цензуры в сети&nbsp;</span><a href="http://habrahabr.ru/post/136396/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">англоязычная Википедия в январе этого</a><span style=" text-align: left; ">&nbsp;и&nbsp;</span><a href="http://habrahabr.ru/post/129771/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">итальянский раздел в октябре прошлого</a><span style=" text-align: left; ">&nbsp;года.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">Примечание. Некоторые ссылки могут перестать работать в полночь.</span><br style=" text-align: left; "><br style=" text-align: left; "><span style=" text-align: left; ">UPD 23:30 Опрос завершён. Готовится подведение итога.</span><br style=" text-align: left; "><span style=" text-align: left; ">UPD2 00:00 Блокировки нет. Итог всё ещё не подведён. На&nbsp;</span><a href="http://ru.wikipedia.org/wiki/%D0%9E%D0%B1%D1%81%D1%83%D0%B6%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5_%D0%92%D0%B8%D0%BA%D0%B8%D0%BF%D0%B5%D0%B4%D0%B8%D0%B8:%D0%9E%D0%BF%D1%80%D0%BE%D1%81%D1%8B/%D0%97%D0%B0%D0%B1%D0%B0%D1%81%D1%82%D0%BE%D0%B2%D0%BA%D0%B0_%D0%BF%D1%80%D0%BE%D1%82%D0%B8%D0%B2_%D1%86%D0%B5%D0%BD%D0%B7%D1%83%D1%80%D1%8B_%D0%B2_%D0%A0%D1%83%D0%BD%D0%B5%D1%82%D0%B5" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">странице обсуждения опроса</a><span style=" text-align: left; ">&nbsp;дискутируют по поводу скороспелости инициативы и процедурных аспектов.</span><br style=" text-align: left; "><span style=" text-align: left; ">UPD3 Подведение итога опроса, а также определение времени и даты начала акции перенесено на час позже.</span><br style=" text-align: left; "><span style=" text-align: left; ">UPD4 Готов&nbsp;</span><a href="http://ru.wikimedia.org/wiki/%D0%97%D0%B0%D0%B1%D0%B0%D1%81%D1%82%D0%BE%D0%B2%D0%BA%D0%B0_%D0%92%D0%B8%D0%BA%D0%B8%D0%BF%D0%B5%D0%B4%D0%B8%D0%B8_%D0%BD%D0%B0_%D1%80%D1%83%D1%81%D1%81%D0%BA%D0%BE%D0%BC_%D1%8F%D0%B7%D1%8B%D0%BA%D0%B5" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">пресс-релиз акции</a><span style=" text-align: left; ">. Появились&nbsp;</span><a href="http://www.lenta.ru/news/2012/07/09/blackout/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">первые отклики в прессе</a><span style=" text-align: left; ">.</span><br style=" text-align: left; "><span style=" text-align: left; ">UPD5 01:00 Итог подведён.&nbsp;</span><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; text-align: left; ">Забастовка</b><span style=" text-align: left; ">.</span><br style=" text-align: left; "><span style=" text-align: left; ">UPD6 Для самых любопытных и нетерпеливых копии опроса и обсуждения&nbsp;</span><a href="https://www.dropbox.com/sh/2kxfmch6ygqj7sc/JTucEkwmNf" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">на dropbox</a><span style=" text-align: left; ">.</span><br style=" text-align: left; "><span style=" text-align: left; ">UPD7&nbsp;</span><a href="http://ru.m.wikipedia.org/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">Мобильная версия</a><span style=" text-align: left; ">&nbsp;пока работает.</span><br style=" text-align: left; "><span style=" text-align: left; ">UPD8 К акции подключился Два.ч (2ch.so).</span><br style=" text-align: left; "><span style=" text-align: left; ">UPD9 Глава Минкомсвязи&nbsp;</span><a href="https://twitter.com/nnikiforov/status/222555596212277249" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">не поддерживает, но признал</a><span style=" text-align: left; ">&nbsp;важный сигнал к тому, чтобы совершенствовать закон.</span><br style=" text-align: left; "><span style=" text-align: left; ">UPD10 Помимо просьбы о распространении информации, обращение от лица редакторов русскоязычной Википедии&nbsp;</span><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; text-align: left; ">призывает каждого</b><span style=" text-align: left; ">&nbsp;лично обратиться к депутатам. Нехитрая процедура подробно описана&nbsp;</span><a href="http://habrahabr.ru/post/147484/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">здесь</a><span style=" text-align: left; ">&nbsp;же на Хабре.</span>&nbsp;<span rel="pastemarkerend" id="pastemarkerend9326"></span><br>\r\n\r\n</p>\r\n', 'wikipedia, цензура в интернете', 2, '2012-07-10 05:15:59', '2012-07-10 05:33:15', 3),
(47, 'Регулярные выражения для валидации распространенных видов данных', '<p><span style=" text-align: left; ">Для проверки текстовых полей на валидность обычно используют регулярные выражения. Существует несколько наиболе распространенных видов таких даных, как например номер кредитки, дата в определенном формате и т. д. На сайте&nbsp;</span><a href="http://html5pattern.com/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">html5pattern.com</a><span style=" text-align: left; ">&nbsp;собирается коллекция регулярных выражений для таких данных (там это позиционируется, как возможное содержимое html5-атрибута pattern у inpit-элементов, но эти регулярные выражения можно использовать и для привычной валидации с помощью javascript). Актуальные для российской аудитории примеры, вместе с соответствующими регулярными выражениями вы можете посмотреть под катом.</span><br style=" text-align: left; ">\r\n</p>\r\n\r\n\r\n<ul style="margin-left: 20px; border-width: 0px; vertical-align: baseline; outline: 0px; list-style-position: outside; list-style-image: initial; text-align: left; ">\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Номер кредитки:</b><br>\r\n\r\n[0-9]{13,16}</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">ICQ:</b><br>\r\n\r\n([1-9])+(?:-?\\d){4,}</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Набор из букв и цифр</b>&nbsp;(латиница):<br>\r\n\r\n^[a-zA-Z0-9]+$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Набор из букв и цифр</b>&nbsp;(латиница + кириллица):<br>\r\n\r\n^[а-яА-ЯёЁa-zA-Z0-9]+$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Домен</b>&nbsp;(например abcd.com):<br>\r\n\r\n^([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,6}$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">IPv4:</b><br>\r\n\r\n((25[0-5]|2[0-4]\\d|[01]?\\d\\d?)\\.){3}(25[0-5]|2[0-4]\\d|[01]?\\d\\d?)</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">IPv6:</b><br>\r\n\r\n((^|:)([0-9a-fA-F]{0,4})){1,8}$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Имя пользователя</b>&nbsp;(с ограничением 2-20 символов, которыми могут быть буквы и цифры, первый символ обязательно буква):<br>\r\n\r\n^[a-zA-Z][a-zA-Z0-9-_\\.]{1,20}$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Пароль</b>&nbsp;(Строчные и прописные латинские буквы, цифры):<br>\r\n\r\n^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\\s).*$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Пароль</b>&nbsp;(Строчные и прописные латинские буквы, цифры, спецсимволы. Минимум 8 символов):<br>\r\n\r\n(?=^.{8,}$)((?=.*\\d)|(?=.*\\W+))(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Дата в формате YYYY-MM-DD:</b><br>\r\n\r\n[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])&nbsp;<br>\r\n\r\n<i style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">UPD.</i>&nbsp;Более строгая проверка:<br>\r\n\r\n(19|20)\\d\\d-((0[1-9]|1[012])-(0[1-9]|[12]\\d)|(0[13-9]|1[012])-30|(0[13578]|1[02])-31)</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Дата в формате DD/MM/YYYY:</b><br>\r\n\r\n(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\\d\\d</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Целые числа и числа с плавающей точкой</b>&nbsp;(разделитель точка):<br>\r\n\r\n\\-?\\d+(\\.\\d{0,})?</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">UUID</b>:<br>\r\n\r\n^[0-9A-Fa-f]{8}\\-[0-9A-Fa-f]{4}\\-[0-9A-Fa-f]{4}\\-[0-9A-Fa-f]{4}\\-[0-9A-Fa-f]{12}$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">Широта или долгота</b>:<br>\r\n\r\n-?\\d{1,3}\\.\\d+</li></ul>\r\n\r\n<br style=" text-align: left; ">\r\n\r\n<ul style="margin-left: 20px; border-width: 0px; vertical-align: baseline; outline: 0px; list-style-position: outside; list-style-image: initial; text-align: left; ">\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; "><i style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">UPD</i>. E-mail</b>:<br>\r\n\r\n^[-\\w.]+@([A-z0-9][-A-z0-9]+\\.)+[A-z]{2,4}$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; "><i style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">UPD</i>. URL</b>&nbsp;на латинице. Если нужно распознавать и кириллические домены, необходимо изменить все «a-z0-9» на «а-яёa-z0-9» и добавить в список доменных зон «рф»:<br>\r\n\r\n~^(?:(?:https?|ftp|telnet)://(?:[a-z0-9_-]{1,32}(?::[a-z0-9_-]{1,32})?@)?)?(?:(?:[a-z0-9-]{1,128}\\.)+(?:ru|su|com|net|org|mil|edu|arpa|gov|biz|info|aero|inc|name|[a-z]{2})|(?!0)(?:(?!0[^.]|255)[0-9]{1,3}\\.){3}(?!0|255)[0-9]{1,3})(?:/[a-z0-9.,_@%&amp;?+=\\~/-]*)?(?:#[^ ''\\"&amp;]*)?$~i</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; "><i style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">UPD</i>. Время в формате HH:MM:SS</b>:<br>\r\n\r\n^([0-1]\\d|2[0-3])(:[0-5]\\d){2}$</li>\r\n\r\n	<li style="margin: 0px 0px 0px 20px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; list-style-type: disc; list-style-position: outside; list-style-image: initial; "><b style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; "><i style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; ">UPD</i>. Mac-адрес</b>:<br>\r\n\r\n([0-9a-fA-F]{2}([:-]|$)){6}$|([0-9a-fA-F]{4}([.]|$)){3}</li></ul>\r\n\r\n<br style=" text-align: left; "><span style=" text-align: left; ">Неуказанные, но важные на ваш взгляд типы данных, можете выкладывать в комментариях (вместе с регулярными выражениями). Можете так же поделиться ими с&nbsp;</span><a href="http://html5pattern.com/" style="margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; outline: 0px; color: rgb(153, 0, 153); text-align: left; ">html5pattern.com</a><span style=" text-align: left; ">, заполнив форму на главной странице.</span>&nbsp;<span rel="pastemarkerend" id="pastemarkerend17720"></span><br>\r\n', 'регулярные выражения, валидация', 2, '2012-07-10 05:35:10', '2012-07-10 05:36:04', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `tbl_tag`
--

INSERT INTO `tbl_tag` (`id`, `name`, `frequency`) VALUES
(4, 'цензура в интернете', 1),
(5, 'wikipedia', 1),
(6, 'регулярные выражения', 1),
(7, 'валидация', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=60 ;

--
-- Дамп данных таблицы `tbl_vote`
--

INSERT INTO `tbl_vote` (`id`, `comment_id`, `author_id`, `value`) VALUES
(32, 772, 1, -1),
(33, 774, 1, 1),
(34, 776, 1, 1),
(35, 779, 1, 1),
(36, 781, 1, -1),
(37, 782, 1, -1),
(38, 785, 1, 1),
(39, 790, 1, 1),
(40, 784, 3, 1),
(41, 789, 3, 1),
(42, 786, 3, 1),
(43, 772, 3, -1),
(44, 774, 3, 1),
(45, 776, 3, 1),
(46, 780, 3, 1),
(47, 784, 5, 1),
(48, 789, 5, 1),
(49, 786, 5, 1),
(50, 772, 5, -1),
(51, 774, 5, 1),
(52, 776, 5, 1),
(53, 781, 5, -1),
(54, 780, 5, 1),
(55, 784, 4, 1),
(56, 785, 4, -1),
(57, 789, 4, 1),
(58, 790, 4, 1),
(59, 785, 5, -1);

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
