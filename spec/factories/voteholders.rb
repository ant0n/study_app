FactoryGirl.define do
  factory :voteholder_answer, :class => 'Voteholder' do
    votable { create(:answer) }
    vote_count 0
  end

end
