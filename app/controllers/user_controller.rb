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

  post '/users' do
    #raise params.inspect
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

end
