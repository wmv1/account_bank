require 'rails_helper'

RSpec.describe UsersController do
  describe "POST create" do
    context 'when params is correct' do
      it "creates user and return token auth" do
        params = {"username": "user2", "password": "12345678"}
        post :create, params: {user:  params}

        expect(JSON.parse(response.body).has_key?("token")).to eq(true)
        expect(response.status).to eq(201)
      end
    end

    context 'when user exists' do
      it "alert that user exists" do
        create(:user, id: 1, username: 'ximbinha', password: '12345678')
        params = {"username": "ximbinha", "password": "12345678"}
        post :create, params: {user:  params}

        expect(JSON.parse(response.body).has_key?("token")).to eq(false)
        expect(JSON.parse(response.body)["message"]).to eq('Validation failed: Username has already been taken')
        expect(response.status).to eq(422)
      end
    end

    context 'when params is correct' do
      it "does return alert message" do
        params = {"usernames": "user2", "passwords": "12345678"}
        message = "Validation failed: Username can't be blank, Password can't be blank, Password is too short (minimum is 6 characters)"

        post :create, params: {user:  params}

        expect(JSON.parse(response.body).has_key?("token")).to eq(false)
        expect(JSON.parse(response.body)["message"]).to eq(message)
        expect(response.status).to eq(422)
      end
    end
  end
end