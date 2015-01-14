class Vote < ActiveRecord::Base
  belongs_to :voter, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voteholder

  after_create :set_count
  after_update :update_count

  validates_uniqueness_of :user_id, scope: :voteholder_id

  def like?
    vote_flag
  end

  def dislike?
    !vote_flag
  end

  private

    def set_count
      vh = voteholder
      vote_flag ? vh.vote_count += 1 : vh.vote_count -= 1
      vh.save
    end

    def update_count
      vh = voteholder
      if vote_flag_was != vote_flag
        vote_flag ? vh.vote_count += 2 : vh.vote_count -= 2
      end
      vh.save
    end
end