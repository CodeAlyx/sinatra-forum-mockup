module Helpers

  def logged_in?(session = {})
    !!session[:user_id]
  end

  def current_user(session = {})
    User.find_by_id(session[:user_id])
  end

  def password_validation(session = {})
    session[:user][:password] == session[:password_validation]
  end

end
