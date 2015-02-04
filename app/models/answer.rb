class Answer < ActiveRecord::Base
  include Votable

  belongs_to :question
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, as: :commentable
  has_many :attachments, -> { order created_at: :desc }, as: :attachmentable

  before_update :check_best

  default_scope { preload(:attachments).order('is_best desc, created_at') }

  validates :body, presence: true

  accepts_nested_attributes_for :attachments

  private

    def check_best
      if is_best != is_best_was
        self.question.answers.where(is_best: true).update_all(is_best: false)
      end
    end
end
