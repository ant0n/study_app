require 'rails_helper'

RSpec.describe Answer, :type => :model do
  it { should belong_to :author }
  it { should belong_to :question }
  it { should have_many :comments }
  it { should have_many :attachments }
  
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }

end
