require 'rails_helper'

RSpec.describe VotesController, :type => :controller do
  sign_in_user

  describe 'GET #vote_up' do
    let!(:answer) { create :answer }

    it 'creating new vote' do
      expect {post 'vote_up', object: 'answer', id: answer, format: :js}.to change(Vote, :count).by(1)
    end

    it 'updated vote' do
      vote = create :vote_up, voteholder: answer.voteholder, voter: @user

      #expect(assigns(:vote).voteholder.vote_count).to eq -1
      #expect(assigns(:vote)).to_not be_a_new(Vote)
      expect{post 'vote_down', object: 'answer', id: answer, format: :js}.to_not change(Vote, :count)
    end
  end

end
