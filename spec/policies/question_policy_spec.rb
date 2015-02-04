require 'rails_helper'

describe QuestionPolicy do

  let(:user)     { create :user }
  let(:question) { create :question, author: user }

  subject { QuestionPolicy }

  [:edit?, :update?, :destroy?].each do |k|
    permissions k do
      it 'grant access if user is author' do
        expect(subject).to permit(user, question)
      end

      it 'denies access if user is not author' do
        expect(subject).not_to permit(User.new, question)
      end
    end
  end
end
