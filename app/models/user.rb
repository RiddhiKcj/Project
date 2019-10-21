class User < ApplicationRecord
  has_secure_password
  has_many :selectedwidgets , dependent: :destroy
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :on => :create
  validates_presence_of :email, :on => :create
end


