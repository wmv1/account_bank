require 'rails_helper'

RSpec.describe TokensController do
  describe "POST create" do

    context 'when params is correct' do
      it "creates user token" do
        create(:user, id: 1, username: 'ximbinha', password: '12345678')
        params = {"username": "ximbinha", "password": "12345678"}
        post :create, params: params

        expect(JSON.parse(response.body).has_key?("token")).to eq(true)
        expect(response.status).to eq(201)
      end
    end

    context 'when user not exist' do
      it "does return unauthorized" do
        params = {"username": "user2ddd", "password": "2345678"}

        post :create, params: params

        expect(response.body).to be_empty
        expect(response.status).to eq(401)
      end
    end

    context 'when params is invalid' do
      it "does return unauthorized" do
        params = {"usernames": "user2", "passwords": "12345678"}

        post :create, params: params

        expect(response.body).to be_empty
        expect(response.status).to eq(401)
      end
    end
  end
end