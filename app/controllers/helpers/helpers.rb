module ApplicationController::Helpers

  def logged_in?(session = {})
    !!session[:user_id]
  end

  def current_user(session = {})
    User.find_by_id(session[:user_id])
  end

  def password_validation(params = {})
    params[:user][:password] == params[:password_verification]
  end

  def password_authentification(params = {})
    user = User.find_by(username: params[:username])
    user.authenticate(params[:password])
  end

  def user_exists?(params = {})
    !!User.find_by(username: params[:username])
  end

  def forum_exists?(params = {})
    !!Forum.find_by(title: params[:title])
  end

end
