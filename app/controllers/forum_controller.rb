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

  get '/forums/:slug/posts/:id/edit' do
    @forum = Forum.find_by_slugF(params[:slug])
    @post = @forum.posts.find_by_id(params[:id])
    erb :'posts/edit'
  end

  post '/forums/:slug/posts/:id' do
    forum = Forum.find_by_slugF(params[:slug])
    post = forum.posts.find_by_id(params[:id])
    post.update(params[:post])
    forum.save
    redirect "/forums/#{forum.slugF}"
  end

  post '/forums/:slug/posts' do
    forum = Forum.find_by_slugF(params[:slug])
    forum.posts.build(content: params[:post][:content], user_id: current_user(session).id)
    forum.save
    redirect "/forums/#{forum.slugF}"
  end
end
