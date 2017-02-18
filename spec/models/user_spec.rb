require 'spec_helper'

describe User do
  before do
    @user1 = User.create(username: "CodeAlyx", email: "123@abc.com", password: "private")
    @user2 = User.create(username: "Guy_Talks88", email: "456@pickupsticks.com", password: "puzzler")
    @user3 = User.create(username: "Frank Sinatra", email: "789@theDime.com", password: "classy")
    @forum1 = Forum.create(title: "The Whole Truth", topic: "Its all lies", user_id: @user1.id)
    @forum2 = Forum.create(title: "How to Have Class", topic: "Teaching you to be classy", user_id: @user3.id)
    @post = Post.create(content: "jibber jabber", user_id: @user1.id, forum_id: @forum1.id)
  end

  after do
    User.delete_all
    Forum.delete_all
    Post.delete_all
  end

  it "has a username, email" do
    expect(@user1.username).to eq("CodeAlyx")
    expect(@user1.email).to eq("123@abc.com")
  end

  it "has many forums" do
    expect(@user1.forums.size).to eq(1)
  end

  it "has many posts" do
    expect(@user1.posts.size).to eq(1)
  end
end
