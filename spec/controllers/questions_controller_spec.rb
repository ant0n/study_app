require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  sign_in_user

  describe 'GET #index' do
   let(:questions) { create_pair(:question) }

   before { get :index }

   it 'populates an array of all question' do
     expect(assigns(:questions)).to include *questions
   end

   it 'render index view' do
     expect(response).to render_template :index
   end
 end

  describe 'GET  #show' do
    let(:question) { create(:question) }

    before { get :show, id: question }

    it 'assingss  the requested question to Question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assings a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new  view' do
      expect(response).to render_template :new
    end

  end

  describe 'GET #edit' do
    let(:question) { create(:question, author: @user) }

    it 'check authorization' do
      expect(controller).to receive(:authorize).with(question)
      post :edit, id: question
    end

    context 'Author of question' do
      before { get :edit, id: question }

      it 'assigns the requestess question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'render edit view' do
        expect(response).to  render_template :edit
      end
    end

    context 'Not an author of question' do
      let(:user2)     { create(:user) }
      let(:question2) { create(:question, author: user2) }

      it 'redirects to question path' do
        expect{ get :edit, id: question2 }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      let(:question) { attributes_for(:question) }

      it 'saves the new question in db' do
        expect{post :create, question: question}.to change(Question, :count).by(1)
      end

      it 'success' do
        post :create, question: question
        expect(response).to redirect_to assigns(:question)
      end

    end

    context 'with invalid attributes' do
      let(:invalid_question) { attributes_for(:invalid_question) }

      it 'does not save question' do
        expect {post :create, question: invalid_question}.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, question: invalid_question
        expect(response).to render_template :new
      end

    end
  end

  describe 'PATCH #update' do

    let(:question) { create(:question, author: @user) }

    it 'check authorization' do
      expect(controller).to receive(:authorize).with(question)
      patch :update, id: question, question: { title: 'new title', body: 'new body'}
    end

    context 'Author of question' do

      context 'valid attributes' do

        it 'assings the requested question to @question' do
          patch :update, id: question, question: { title: 'new title', body: 'new body'}
          expect(assigns(:question)).to eq question
        end

        it 'changes question attributes' do
          patch :update, id: question, question: { title: 'new title', body: 'new body'}
          question.reload
          expect(question.title).to eq 'new title'
          expect(question.body).to eq 'new body'
        end

        it 'redirects to the updated question' do
          patch :update, id: question, question: { title: 'new title', body: 'new body'}
          expect(response).to redirect_to question
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

      it 'redirects to question path' do
        expect{ get :edit, id: question2 }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'DELETE #destroy' do

    let(:question) { create(:question, author: @user) }
    before { question }

    it 'check authorization' do
      expect(controller).to receive(:authorize).with(question)
      post :destroy, id: question
    end

    it 'deletes question' do
      expect{ delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end


    it 'redirects to question path' do
      user2     = create :user
      question2 = create :question, author: user2

      expect{ delete :destroy, id: question2 }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
