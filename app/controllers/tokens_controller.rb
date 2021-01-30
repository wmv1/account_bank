class TokensController < ApplicationController
  def create
    user_name, password = token_params.values_at(:username, :password)
    user = User.find_by(username: user_name)
    return head :unauthorized if user.nil? or !user.valid_password?(password)
    render json: payload(user)
  end

  private
  def payload(user)
    return nil unless user and user.id
    {token: JwtToken.encode({user_id: user.id})}
  end

  def token_params
    params.permit(:username, :password)
  end
end