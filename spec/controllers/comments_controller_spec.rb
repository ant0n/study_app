require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
=begin
  sign_in_user
  let(:answer) { create :answer }

  describe 'GET #new' do
    before { get :new, answer: answer, format: :js }

    it 'assings a new Question to @question' do
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it 'render new  view' do
      expect(response).to render_template :new
    end

  end

  describe 'GET #edit' do
    let(:comment) { create(:comment, user: @user, commentable: answer) }

    context 'Author of question' do
      before { get :edit, id: comment }

      it 'assigns the requesting comment to @comment' do
        expect(assigns(:comment)).to eq question
      end

      it 'render edit view' do
        expect(response).to  render_template :edit
      end
    end

    context 'Not an author of comment' do
      let(:user2)     { create(:user) }
      let(:comment2) { create(:comment, user: user2) }

      before { get :edit, id: comment2 }

      it 'redirects to question path' do
        expect(response.status).to eq 403
      end
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      let(:comment) { attributes_for(:comment) }

      it 'saves the new question in db' do
        expect{post :create, comment: comment, answer_id: answer}.to change(Comment, :count).by(1)
      end

      it 'success' do
        post :create, comment: comment
        expect(response).to redirect_to assigns(:comment)
      end

    end

    context 'with invalid attributes' do
      let(:invalid_comment) { attributes_for(:invalid_comment) }

      it 'does not save question' do
        expect {post :create, comment: invalid_comment, answer: answer}.to_not change(Comment, :count)
      end

      it 're-renders new view' do
        post :create, comment: invalid_comment
        expect(response).to render_template :new
      end

    end
  end

  describe 'PATCH #update' do

    let(:comment) { create(:comment, user: @user) }
    context 'Author of question' do

      context 'valid attributes' do

        it 'assings the requested question to @question' do
          patch :update, id: comment, comment: {body: 'new body'}, format: :js
          expect(assigns(:comment)).to eq comment
        end

        it 'changes question attributes' do
          patch :update, id: comment, comment: {body: 'new body'}, format: :js
          expect(comment.reload.body).to eq 'new body'
        end

        it 'redirects to the updated question' do
          patch :update, id: comment, comment: {body: 'new body'}, format: :js
          expect(response.status).to eq 200
        end
      end

      context 'invalid attributes' do
        before { patch :update, id: question, question: { title: 'new title', body: nil} }

        it 'does not change question attributes' do
          question.reload
          expect(question.title).to eq 'MyString'
          expect(question.body).to eq 'MyText'
        end

        it 're-renders edit view' do
          expect(response).to render_template :edit
        end
      end

    end

    context 'not an author of question' do

      let(:user2)     { create(:user) }
      let(:question2) { create(:question, author: user2) }

      before { get :edit, id: question2 }

      it 'redirects to question path' do
        expect(response).to redirect_to question_path(question2)
      end
    end
  end

  describe 'DELETE #destroy' do

    let(:question) { create(:question, author: @user) }
    before { question }

    it 'deletes question' do
      expect{ delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end
=end
end
