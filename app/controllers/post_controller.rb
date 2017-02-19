class PostController < ApplicationController

  get '/forums/:slug/posts/:id/edit' do
    @forum = Forum.find_by_slugF(params[:slug])
    @post = @forum.posts.find_by_id(params[:id])
    if !!@post
      if @post.user_id == current_user(session).id
        erb :'posts/edit'
      else
        flash[:message] = "You Do Not Have Permission To Edit This Post"
        redirect "/forums/#{@forum.slugF}"
      end
    else
      flash[:message] = "This Post Does Not Exist"
      redirect "/forums/#{@forum.slugF}"
    end
  end

  get '/forums/:slug/posts/:id/delete' do
    @forum = Forum.find_by_slugF(params[:slug])
    @post = @forum.posts.find_by_id(params[:id])
    if !!@post
      if @post.user_id == current_user(session).id
        erb :'posts/delete'
      else
        flash[:message] = "You Do Not Have Permission To Edit This Post"
        redirect "/forums/#{@forum.slugF}"
      end
    else
      flash[:message] = "This Post Does Not Exist"
      redirect "/forums/#{@forum.slugF}"
    end
  end

  post '/forums/:slug/posts' do
    forum = Forum.find_by_slugF(params[:slug])
    forum.posts.build(content: params[:post][:content], user_id: current_user(session).id)
    forum.save
    redirect "/forums/#{forum.slugF}"
  end

  patch '/forums/:slug/posts/:id' do
    forum = Forum.find_by_slugF(params[:slug])
    post = forum.posts.find_by_id(params[:id])
    if post.user_id == current_user(session).id
      post.update(params[:post])
      redirect "/forums/#{forum.slugF}"
    else
      flash[:message] = "You Do Not Have Permission To Edit This Post"
      redirect "/forums/#{forum.slugF}"
    end
  end

  delete '/forums/:slug/posts/:id' do
    forum = Forum.find_by_slugF(params[:slug])
    post = forum.posts.find_by_id(params[:id])
    if post.user_id == current_user(session).id
      post.delete
      flash[:message] = 'Post Successfully Deleted'
      redirect "/forums/#{forum.slugF}"
    else
      flash[:message] = "You Do Not Have Permission To Edit This Post"
      redirect "/forums/#{forum.slugF}"
    end
  end

end
