require 'rails_helper'

RSpec.describe Vote, :type => :model do
  it { should belong_to :voteholder }
  it { should belong_to :voter }
end
