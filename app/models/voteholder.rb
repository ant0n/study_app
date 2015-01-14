class Voteholder < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  has_many :votes
end
