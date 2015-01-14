require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      let(:question) {create(:question)}
      let(:answer) { attributes_for(:answer, question_id: question) }

      it 'saves the new answer in db' do
        expect{post :create, answer: answer, question_id: question, format: :json}.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, answer: answer, question_id: question, format: :json
        expect(response.status).to render_template :create
      end

    end

    context 'with invalid attributes' do
      let(:question) {create(:question)}
      let(:invalid_answer) { attributes_for(:invalid_answer) }

      it 'does not save answer' do
        expect {post :create, answer: invalid_answer, question_id: question, format: :json}.to_not change(Answer, :count)
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let(:question) {create(:question)}
    let(:answer) { create(:answer, author: @user) }

    context 'valid attributes' do

      it 'assings the requested answer to @answer' do
        patch :update, id: answer, answer: { body: 'new body'}, question_id: question, format: :js
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, id: answer, answer: { body: 'new body'}, question_id: question, format: :js
        expect(answer.reload.body).to eq 'new body'
      end

      it 'respond  with Accepted' do
        patch :update, id: answer, answer: { body: 'new body'}, question_id: question, format: :js
        expect(response.status).to eq 200
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: answer, answer: { body: nil}, question_id: question, format: :js }

      it 'does not change answer attributes' do
        expect(answer.reload.body).to eq 'MyText'
      end
    end

    context 'not an author of answer tried to change it' do
      let(:user2)    { create :user }
      let!(:answer2) { create :answer, question: question, author: user2 }
      before { patch :update, id: answer2, answer: { body: 'new body'}, question_id: question, format: :js }

      it "does not change answer attributes" do
        expect(answer2.body).to eq "MyText"
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    let(:question) {create(:question)}
    let!(:answer) { create(:answer, author: @user) }

    it 'deletes answer' do
      expect{ delete :destroy, id: answer, question_id: question, format: :js }.to change(Answer, :count).by(-1)
    end

    it 'response with Accepted' do
      delete :destroy, id: answer, question_id: question, format: :js
      expect(response.status).to eq 202
    end
  end

  describe 'POST #set_best' do
    sign_in_user

    let(:user2)     { create(:user) }
    let!(:question) { create(:question, author: @user) }
    let!(:answer)   { create(:answer, question: question, author: user2) }

    context 'Author of question' do

      it 'marked the best answer' do
        post :set_best, id: answer, question_id: question, format: :js

        expect(answer.reload.is_best).to eq true
      end
    end

    context 'Not an author of question' do
      let!(:question2) { create(:question, author: user2) }
      let(:answer2)    { create(:answer, question: question2, author: user2)}

      it 'raise a permission denied error' do
        post :set_best, id: answer2, question_id: question2, format: :js

        expect(response.status).to eq 550
      end
    end
  end


end
