require 'spec_helper'

describe Post do

  it "has content" do
    user = User.create(username: "CodeAlyx", email: "123@abc.com", password: "private")
    forum = Forum.create(title: "The Whole Truth", topic: "I will uncover all the lies.", user_id: user.id)
    post = Post.create(content: "jibber jabber", user_id: user.id, forum_id: forum_id)

    expect(post).to include(:content)
  end

  it "belongs to a user" do
    user = User.create(username: "CodeAlyx", email: "123@abc.com", password: "private")
    forum = Forum.create(title: "The Whole Truth", topic: "I will uncover all the lies.", user_id: user.id)
    post = Post.create(content: "jibber jabber", user_id: user.id, forum_id: forum_id)

    expect(post.user).to eq(true)
  end

  it "belongs to a forum" do
    user = User.create(username: "CodeAlyx", email: "123@abc.com", password: "private")
    forum = Forum.create(title: "The Whole Truth", topic: "I will uncover all the lies.", user_id: user.id)
    post = Post.create(content: "jibber jabber", user_id: user.id, forum_id: forum_id)

    expect(post.forum).to eq(true)
  end
end
