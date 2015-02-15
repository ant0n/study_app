class QuestionWorker
  include Sidekiq::Worker

  def perform(user_ids, answer)
    User.where(id: user_ids).find_each do |user|
      DailyMailer.delay.question_notification(user, answer)
    end
  end

end