class Answer < ActiveRecord::Base
  include Votable

  belongs_to :question, touch: true
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, as: :commentable
  has_many :attachments, -> { order created_at: :desc }, as: :attachmentable

  after_create :send_notification

  before_update :check_best

  scope :with_attachments, -> { preload(:attachments).order('is_best desc, created_at') }

  validates :body, presence: true

  accepts_nested_attributes_for :attachments


  scope :for_notification, -> {
    joins(question: :author)
    .where('answers.question_notificated = false AND answers.created_at > users.last_sign_in_at')
  }

  def question_notificated!
    update(question_notificated: true)
  end

  private

    def check_best
      if is_best != is_best_was
        self.question.answers.where(is_best: true).update_all(is_best: false)
      end
    end

    def send_notification
      user_ids = question.notifications.map(&:user_id)
      QuestionWorker.perform_async(user_ids, self)
    end
end
