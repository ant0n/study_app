FactoryGirl.define do
  factory :vote_up, :class => 'Vote' do
    vote_flag false
    voter { create :user }
    voteholder { create(:voteholder_answer) }
  end

  factory :vote_down, :class => 'Vote' do
    vote_flag false
    voter { create :user }
    voteholder { create(:voteholder_answer) }
  end
end
