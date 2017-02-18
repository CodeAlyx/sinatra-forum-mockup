require 'spec_helper'

describe User do
  before do
    user1 = User.create(username: "CodeAlyx", email: "123@abc.com", password: "private")
    user2 = User.create(username: "Guy_Talks88", email: "456@pickupsticks.com", password: "puzzler")
    user3 = User.create(username: "Frank Sinatra", email: "789@theDime.com", password: "classy")
    forum1 = Forum.create(title: "The Whole Truth", user_id: "#{user1.id}")
    forum2 = Forum.create(title: "How to Have Class", user_id: "#{user3.id}")
    
  end
end
