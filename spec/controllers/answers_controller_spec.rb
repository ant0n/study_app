require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      let(:question) {create(:question)}
      let(:answer) { attributes_for(:answer, question_id: question.id) }

      it 'saves the new answer in db' do
        expect{post :create, answer: answer}.to change(Answer, :count).by(1)
      end

      it 'responds with Accepted status code' do
        post :create, answer: answer
        expect(response).to redirect_to question_path(question)
      end

    end

    context 'with invalid attributes' do
      let(:invalid_answer) { attributes_for(:invalid_answer) }

      it 'does not save answer' do
        expect {post :create, answer: invalid_answer}.to_not change(Answer, :count)
      end

      it 'respond with Bad Request status code' do
        post :create, answer: invalid_answer
        expect(response.status).to eq 400
      end

    end
  end

  describe 'PATCH #update' do
    sign_in_user

    let(:answer) { create(:answer) }

    context 'valid attributes' do

      it 'assings the requested answer to @answer' do
        patch :update, id: answer, answer: { body: 'new body'}
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, id: answer, answer: { body: 'new body'}
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'respond  with Accepted' do
        patch :update, id: answer, answer: { body: 'new body'}
        expect(response.status).to eq 202
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: answer, answer: { body: nil} }

      it 'does not change answer attributes' do
        answer.reload
        expect(answer.body).to eq 'MyText'
      end

      it 'respond with Bad Request' do
        expect(response.status).to eq 400
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    let(:answer) { create(:answer) }
    before { answer }

    it 'deletes answer' do
      expect{ delete :destroy, id: answer }.to change(Answer, :count).by(-1)
    end

    it 'response with Accepted' do
      delete :destroy, id: answer
      expect(response.status).to eq 202
    end
  end
end
