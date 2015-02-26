class QuestionObserver < ActiveRecord::Observer
  observe :question

  def after_create(question)
    author = question.author
    author.reputation += 1
    author.save
  end

end