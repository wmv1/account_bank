class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.save!
    render json: {token: JwtToken.encode({user_id: user.reload.id})}, status: :created
  end

  rescue_from 'StandardError' do |e|
    render json: {message: e.message}, status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end