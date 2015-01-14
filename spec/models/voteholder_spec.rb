require 'rails_helper'

RSpec.describe Voteholder, :type => :model do
  it { should belong_to :votable }
  it { should have_many :votes }
end
