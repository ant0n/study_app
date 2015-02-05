require 'rails_helper'

describe 'Questions API' do

  describe 'GET /index' do
    it_behaves_like "API Authenticable"

    context 'autorized' do
      let(:access_token) { create :access_token }
      let!(:questions) { create_list :question, 2 }
      let(:question) { questions.first }
      let!(:answer) {create :answer, question: question}

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2).at_path("questions")
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end

      context "answer" do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("questions/0/answers")
        end

        %w(id body created_at updated_at).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
          end
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/questions', {format: :json}.merge(options)
    end
  end

  describe 'GET #show' do
    let(:access_token) { create :access_token }
    let!(:question)     { create :question }
    let(:user)         { create :user }
    let!(:comments)     { create_list :comment, 3, commentable: question, user: user }
    let!(:files)        { create_list :attachment, 3, attachmentable: question }

    it_behaves_like "API Authenticable"

    before { get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token }

    it 'returns 200 status' do
      expect(response).to be_success
    end

    %w(id title body created_at updated_at).each do |attr|
      it "contains #{attr}" do
        expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("question/#{attr}")
      end
    end

    context 'comments' do
      it 'included list of comments' do
        expect(response.body).to have_json_size(3).at_path("question/comments")
      end

      %w(id body created_at).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(comments[0]["#{attr}"].to_json).at_path("question/comments/0/#{attr}")
        end
      end
    end

    context 'files' do
      it 'included url list of files' do
        expect(response.body).to have_json_size(3).at_path("question/attachments")
      end

      it "contains file_url" do
        expect(response.body).to be_json_eql(question.attachments.first.file.url.to_json).at_path("question/attachments/0/file_url")
      end
    end

    def do_request(options = {})
      get "/api/v1/questions/#{question.id}", {format: :json}.merge(options)
    end
  end

  describe 'POST #create' do
    let(:access_token) { create :access_token }
    let!(:question)     { attributes_for(:question) }

    it_behaves_like "API Authenticable"

    it 'create new question' do
      expect{ post "/api/v1/questions", question: question, access_token: access_token.token, format: :json }
          .to change(Question, :count)
    end

    before { post "/api/v1/questions", question: question, access_token: access_token.token, format: :json }

    it 'returns 200 status' do
      expect(response).to be_success
    end

    %w(id title body created_at updated_at).each do |attr|
      it "contains #{attr}" do
        expect(response.body).to be_json_eql(assigns(:question)[attr].to_json).at_path("question/#{attr}")
      end
    end

    def do_request(options = {})
      post "/api/v1/questions", {format: :json}.merge(options)
    end
  end
end