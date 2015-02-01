require 'rails_helper'

describe AnswerPolicy do
  subject { described_class }
  let!(:user) { create(:user) }

  permissions :update? do
    it 'grant access if user is author' do
      expect(subject).to permit(user, create(:answer, author: user))
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(User.new, create(:answer, author: user))
    end
  end

  permissions :set_best? do
    let(:question) { create(:question, author: user) }

    it 'grant access if user is an author of question for this answer' do
      expect(subject).to permit(user, create(:answer, author: user, question: question))
    end

    it 'denied access if user is not an author of question for this answer' do
      expect(subject).to_not permit(User.new, create(:answer, author: user, question: question))
    end
  end

end
