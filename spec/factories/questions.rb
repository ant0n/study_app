FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyText"

    factory :question_with_answers do
      transient do
        answers_count 2
      end

      after(:create) do |question|
        create_list(:answer, evaluator.answer_count, question: question)
      end
    end
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body 'ttt'
  end

end
