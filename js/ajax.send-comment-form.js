$(document).ready(function () {

	/* TODO
	 *  Форма висит три секунды перед добавлением нового комментария
	 *  Не очищается после отправки; если вызвана кнопкой ответить, то исчезает после отправки
	 *  Сортировка по дате добавления
	 */

	var id = null;

	// Добавление нового комментария
	$('#comments').on('submit', '#comment-form', function (e) {
		e.preventDefault();
		$.ajax({
			type:'POST',
			url:$('#comment-form').attr('action'),
			data:$('#comment-form').serialize(),

			beforeSend:function () {
				$('#comment-form').html("<img src='./images/tools/load.gif' border='0'/>")
			},

			// TODO Надо сделать правильнее, но как не знаю
			success:function (data) {
				$('#new_comment').fadeOut();
				$('#comments').load(document.location.href + " #comments > *")
			}
		});
		return false;
	});

	// Перенос формы при нажатии на кнопку Ответить
	$('#comments').on('click', 'a.reply', function (e) {
		e.preventDefault();
		var id = $(this).attr('id');
		$('#Comment_parent_id').attr('value', id);
		$('#new_comment').insertAfter($('#comment_' + id));
		return false;
	});

	// Удаление комментария
	$('#comments').on('click', 'a.delete', function (e) {
		e.preventDefault();

		var cid = $(this).parents("div[class*=comment_item_]").attr('id').substring(8);

		$.getJSON('index.php?r=comment/delete&id=' + cid, {}, function (data) {
			$('#comment_' + data.id).fadeOut();
			$('#comments h3').html(data.countComments + ' комментариев');
		});
	});

	// Оценка комментария
	$('#comments .voting').on('click', 'a', function (e) {
		e.preventDefault();
		//debugger;
		var cid = $(this).parents("div[class*=comment_item_]").attr('id').substring(8);
		var vote = $(this).attr('class');

		$.post(
			'index.php?r=comment/vote',
			{
				id:cid,
				vote:vote
			},

			// TODO Надо сделать правильнее, но как не знаю
			function () {
				$('#comments #comment_' + cid).load('#comments #comment_' + cid + ' > *')
			});
	});

});

