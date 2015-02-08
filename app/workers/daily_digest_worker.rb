class DailyDigestWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1) }

  def perform(name, count)
    questions = Question.where('DATE(created_at) = ? ', Date.today)
    User.find_each do |user|
      DailyMailer.delay.digest(user, questions)
    end
  end

end