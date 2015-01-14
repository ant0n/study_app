module Votable
  extend ActiveSupport::Concern

  included do
    has_one  :voteholder, as: :votable
    has_many :votes,      through: :voteholder
    has_many :voters,     through: :votes

    after_create :create_voteholder

    default_scope { preload(voteholder: :votes) }

    delegate :vote_count, to: :voteholder
  end

end