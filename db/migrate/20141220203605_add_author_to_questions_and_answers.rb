class AddAuthorToQuestionsAndAnswers < ActiveRecord::Migration
  def change
    add_reference :questions, :author, index: true
    add_reference :answers, :author, index: true
  end
end
