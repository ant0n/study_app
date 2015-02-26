class AnswerObserver < ActiveRecord::Observer
  observe :answer

  def after_create(answer)
    author = answer.author
    author.reputation += 2
    author.save
  end

end