FactoryGirl.define do
  factory :answer do
    body "MyText"
    question
    author { create(:user) }
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question
    author { create(:user) }
  end

  factory :best_answer, class: 'Answer' do
    body "MyText"
    is_best true
    question
    author { create(:user) }
  end
end
