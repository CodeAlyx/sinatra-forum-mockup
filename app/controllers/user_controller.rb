class UserController < ApplicationController

  get '/users' do
    erb :'users/index'
  end

  get '/users/signup' do
    if !logged_in?(session)
      erb :'users/new'
    else
      flash[:message] = 'You Are Signed Up'
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

  post '/users' do
    if password_validation(session)
      user = User.create(session[:user])
    else
      flash[:message] = 'Passwords Did Not Match'
      redirect '/users/signup'
    end
  end

end
