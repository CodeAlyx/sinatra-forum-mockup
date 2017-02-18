class Post < ActiveRecord::Base
  include Slugs::InstanceMethods
  extend Slugs::ClassMethods

  belongs_to :user
  belongs_to :forum
  validates :content, presence: true
end
