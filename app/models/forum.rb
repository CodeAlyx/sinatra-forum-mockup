class Forum < ActiveRecord::Base
  include Slugs::InstanceMethods
  extend Slugs::ClassMethods

  belongs_to :user
  has_many :posts
  validates :title, presence: true
  validates :topic, presence: true
end
