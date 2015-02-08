class AnswerWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # для теста на 1 час
  recurrence { hourly(1) }

  # самый простой вариант оповещать только тех авторов вопросов о новых ответах,
  # у которых время последней авторизации меньше времени создания ответа
  # плюс добавим флаг для ответов о том что оповещение уже отправлялось
  # еще как простой вариант добавить поле для юзера с временем последнего оповещения

  # ответы сгруппированы по вопросам
  def perform(name, count)
    Answer.for_notifications.each do |answers|
      DailyMailer.delay.answer_notification(answers)
      answers.each(&:question_notificated!)
    end
  end

end