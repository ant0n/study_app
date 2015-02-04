require 'rails_helper'

describe 'Answers API' do
  let(:access_token) { create :access_token }
  let!(:question) { create :question }
  let!(:answers) { create_list :answer, 3, question: question }

  describe 'GET /index' do
    context 'autorized' do

      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it 'returns list of answers' do
        expect(response.body).to have_json_size(3).at_path("answers")
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answers[0][attr].to_json).at_path("answers/0/#{attr}")
        end
      end
    end
  end

  describe 'GET #show' do
    let(:user)         { create :user }
    let(:answer)       { answers.first }
    let!(:comments)    { create_list :comment, 3, commentable: answer, user: user }
    let!(:files)       { create_list :attachment, 3, attachmentable: answer }

    before { get "/api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: access_token.token }

    it 'returns 200 status' do
      expect(response).to be_success
    end

    %w(id body created_at updated_at).each do |attr|
      it "contains #{attr}" do
        expect(response.body).to be_json_eql(answer[attr].to_json).at_path("answer/#{attr}")
      end
    end

    context 'comments' do
      it 'included list of comments' do
        expect(response.body).to have_json_size(3).at_path("answer/comments")
      end

      %w(id body created_at).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(comments[0][attr].to_json).at_path("answer/comments/0/#{attr}")
        end
      end
    end

    context 'files' do
      it 'included url list of files' do
        expect(response.body).to have_json_size(3).at_path("answer/attachments")
      end

      it "contains file_url" do
        expect(response.body).to be_json_eql(answer.attachments.first.file.url.to_json).at_path("answer/attachments/0/file_url")
      end
    end
  end

  describe 'POST #create' do
    let(:access_token) { create :access_token }
    let(:question)     { create :question }
    let(:answer)       { attributes_for :answer }

    it 'create new question' do
      expect{ post "/api/v1/questions/#{question.id}/answers", answer: answer, format: :json, access_token: access_token.token }
          .to change(Answer, :count)
    end

    before { post "/api/v1/questions/#{question.id}/answers", answer: answer, format: :json, access_token: access_token.token }

    it 'returns 200 status' do
      expect(response).to be_success
    end

    %w(id body created_at updated_at).each do |attr|
      it "contains #{attr}" do
        expect(response.body).to be_json_eql(assigns(:answer)[attr].to_json).at_path("answer/#{attr}")
      end
    end
  end

end