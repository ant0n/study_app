require 'rails_helper'

describe 'Prifoles API' do
  describe 'GET #me' do
    it_behaves_like 'API Authenticable'

    context 'autorized' do
      let(:me) { create :user }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      %w(id email created_at updated_at).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path("user/#{attr}")
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path("user/#{attr}")
        end
      end

    end

    def do_request(options = {})
      get "/api/v1/profiles/me", {format: :json}.merge(options)
    end
  end

  describe 'GET #index' do
    let!(:users)       { create_list :user, 4 }
    let!(:user)        { users.first }
    let(:access_token) { create :access_token, resource_owner_id: user.id }

    it_behaves_like 'API Authenticable'

    before { get '/api/v1/profiles', format: :json, access_token: access_token.token }

    it 'returns 200 status' do
      expect(response).to be_success
    end

    context 'users' do
      it 'included in user object' do
        expect(response.body).to have_json_size(3).at_path("users/")
      end

      it 'not included current_user' do
        expect(assigns(:users).to_json).to_not include_json(user.to_json)
      end

      %w(id email created_at updated_at).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(users[1].send(attr.to_sym).to_json).at_path("users/0/#{attr}")
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end

    def do_request(options = {})
      get "/api/v1/profiles", {format: :json}.merge(options)
    end

  end
end