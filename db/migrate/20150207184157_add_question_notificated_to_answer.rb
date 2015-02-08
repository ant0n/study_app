class AddQuestionNotificatedToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :question_notificated, :boolean, default: false
  end
end
