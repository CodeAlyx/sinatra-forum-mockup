class User < ActiveRecord::Base
  include Slugs::InstanceMethods
  extend Slugs::ClassMethods

  has_many :posts
  has_many :forums
  has_secure_password
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
