class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, foreign_key: :author_id
  has_many :answers, foreign_key: :author_id
  has_many :notifications

  def subscribed?(question)
    Notification.find_by(question_id: question.id, user_id: self.id).present?
  end

  def voted_for?(object, flag)
    Vote.find_by(voteholder: object.voteholder, voter: self.id, vote_flag: flag) ? true : false
  end
end
