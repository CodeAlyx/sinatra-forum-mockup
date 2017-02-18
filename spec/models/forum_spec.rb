require 'spec_helper'

describe Forum do

  it "can be instantiated with a title, topic" do
    user = User.create(username: "CodeAlyx", email: "123@abc.com", password: "private")
    forum = Forum.create(title: "The Whole Truth", topic: "I will uncover all the lies.", user_id: user.id)

    expect(forum).to include(:title)
    expect(forum).to include(:topic)
  end

  it "belongs to a user" do
    user = User.create(username: "CodeAlyx", email: "123@abc.com", password: "private")
    forum = Forum.create(title: "The Whole Truth", topic: "I will uncover all the lies.", user_id: user.id)

    expect(forum.user).to eq(true)
  end

  it "can have many posts" do
    user = User.create(username: "CodeAlyx", email: "123@abc.com", password: "private")
    forum = Forum.create(title: "The Whole Truth", topic: "I will uncover all the lies.", user_id: user.id)

    expect(forum.posts).to eq([])
  end
end