class UserController < ApplicationController

  get '/users' do
    @users = User.all
    erb :'users/index'
  end

  get '/users/signup' do
    if !logged_in?(session)
      erb :'users/new'
    else
      flash[:message] = 'You Are Already Signed Up'
      redirect '/users'
    end
  end

  get '/users/login' do
    if !logged_in?(session)
      erb :'users/login'
    else
      flash[:message] = 'You Are Already Logged In'
      redirect '/users'
    end
  end

  get '/users/logout' do
    session.clear
    redirect '/'
  end

  get '/users/:slug' do
    @user = User.find_by_slugU(params[:slug])
    if @user
      erb :'users/show'
    else
      flash[:message] = "#{params[:slug]} Does Not Exist"
      redirect '/users'
    end
  end

  get '/users/:slug/edit' do
    @user = User.find_by_slugU(params[:slug])
    if current_user(session) == @user
      erb :'users/edit'
    else
      flash[:message] = "You Do Not Have Permission To Edit This Account"
      redirect "/users/#{@user.slugU}"
    end
  end

  get '/users/:slug/delete' do
    @user = User.find_by_slugU(params[:slug])
    if current_user(session) == @user
      erb :'users/delete'
    else
      flash[:message] = "You Do Not Have Permission To Edit This Account"
      redirect "/users/#{@user.slugU}"
    end
  end

  post '/users' do
    if user_exists?(params[:user])
      flash[:message] = "This Username Is Unavailable"
      redirect '/users/signup'
    else
      if password_validation(params)
        user = User.create(params[:user])
        session[:user_id] = user.id
        redirect "/users/#{user.slugU}"
      else
        flash[:message] = 'Passwords Did Not Match'
        redirect '/users/signup'
      end
    end
  end

  post '/users/login' do
    user = User.find_by(username: params[:username])
    if user && password_authentification(params)
      session[:user_id] = user.id
      redirect "/users/#{user.slugU}"
    else
      flash[:message] = "Incorrect Username or Password"
      redirect '/users/login'
    end
  end

  patch '/users/:slug' do
    user = User.find_by_slugU(params[:slug])
    params[:user].delete_if {|key, value| value == ""}
    if password_authentification(params, user)
      if !params.empty? && password_validation(params)
        params[:user][:password] = "#{params[:password]}" if !params[:user][:password]
        user.update(params[:user])
        redirect "/users/#{user.slugU}"
      else
        flash[:message] = "No Data Provided For Update"
        redirect "/users/#{user.slugU}/edit"
      end
    else
      flash[:message] = "Incorrect Password, Profile Update Cancelled"
      redirect "/users/#{user.slugU}/edit"
    end
  end

  delete '/users/:slug' do
    user = User.find_by_slugU(params[:slug])
    if password_authentification(params, user)
      flash[:message] = "#{user.username} Deleted"
      delete_products_of(user.id)
      user.destroy
      session.clear
      redirect '/'
    else
      flash[:message] = "Incorrect Password, Profile Deletion Cancelled"
      redirect "/users/#{user.slugU}"
    end
  end

end
