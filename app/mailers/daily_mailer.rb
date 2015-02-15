class DailyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.daily_d_mailer.digest.subject
  #
  def digest(user, questions)
    @questions = questions
    mail to: user.email, subject: 'Daily digest of questions'
  end

  def answer_notification(answers)
    @answers = answers
    question = answers[0].question
    author   = question.author

    mail to: author.email, subject: "New answers for question: #{view_context.truncate(question.title, length: 15)}"
  end

  def question_notification(user, answer)
    @user     = user
    @answer   = answer

    mail to: @user.email, subject: "New answers for question"
  end
end
