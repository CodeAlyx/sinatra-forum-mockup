class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  validates :content, presence: true
end
