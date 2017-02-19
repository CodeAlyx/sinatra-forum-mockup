class ForumController < ApplicationController

  get '/forums' do
    @forums = Forum.all
    erb :'forums/index'
  end

  get '/forums/new' do
    if logged_in?(session)
      erb :'forums/new'
    else
      flash[:message] = "You Must Log In Or Sign Up To Start A Forum"
      redirect '/'
    end
  end

  get '/forums/:slug' do
    @forum = Forum.find_by_slugF(params[:slug])
    if @forum
      erb :'forums/show'
    else
      flash[:message] = "#{params[:slug]} Does Not Exist"
      redirect '/forums'
    end
  end

  get '/forums/:slug/edit' do
    @forum = Forum.find_by_slugF(params[:slug])
    if @forum.user.id == current_user(session).id
      erb :'forums/edit'
    else
      flash[:message] = "You Do Not Have Permission To Edit This Forum"
      redirect "/forums/#{@forum.slugF}"
    end
  end

  get '/forums/:slug/delete' do
    @forum = Forum.find_by_slugF(params[:slug])
    if @forum.user.id == current_user(session).id
      erb :'forums/delete'
    else
      flash[:message] = "You Do Not Have Permission To Edit This Forum"
      redirect "/forums/#{@forum.slugF}"
    end
  end

  post '/forums' do
    if forum_exists?(params[:forum])
      flash[:message] = "A Forum Already Exists With That Title"
      redirect '/forums/new'
    else
      forum = Forum.create(params[:forum])
      forum.user = current_user(session)
      forum.save
      redirect "/forums/#{forum.slugF}"
    end
  end

  patch '/forums/:slug' do
    forum = Forum.find_by_slugF(params[:slug])
    if params[:forum].has_value?("")
      flash[:message] = "Forums Must Have A Title and Topic"
      redirect "/forums/#{forum.slugF}/edit"
    else
      forum.update(params[:forum])
      redirect "/forums/#{forum.slugF}"
    end
  end

  delete '/forums/:slug' do
    forum = Forum.find_by_slugF(params[:slug])
    flash[:message] = "#{forum.title} Has Been Deleted"
    forum.delete
    redirect '/forums'
  end

end
