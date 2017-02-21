module ApplicationController::Helpers

  def logged_in?(session = {})
    !!session[:user_id]
  end

  def current_user(session = {})
    User.find_by_id(session[:user_id])
  end

  def password_validation(params = {})
    if params[:user][:password] && params[:password_validation]
      params[:user][:password] == params[:password_verification]
    else
      true
    end
  end

  def password_authentification(params = {}, user = nil)
    user ||= User.find_by(username: params[:username])
    user.authenticate(params[:password])
  end

  def user_exists?(params = {})
    !!User.find_by(username: params[:username])
  end

  def forum_exists?(params = {})
    !!Forum.find_by(title: params[:title])
  end

  def delete_products_of(user_id)
    Forum.all.select{|x| x.user_id == user_id}.each do |forum|
      forum.destroy
    end
    Post.all.select{|x| x.user_id == user_id}.each do |post|
      post.destroy
    end
  end
end
