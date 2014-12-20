require 'rails_helper'

RSpec.describe Question, :type => :model do

  it { should belong_to :author }
  it { should have_many :answers }
  it { should have_many :comments }

  it {should validate_presence_of :title}
  it {should validate_presence_of :body}

end