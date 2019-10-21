class User < ApplicationRecord
  has_secure_password
  has_many :selectedwidgets , dependent: :destroy
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :on => :create
  validates_presence_of :email, :on => :create
  validates_format_of  :email, :with => /^[\+A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i, :multiline => true
  validates :password, :presence => true, :confirmation => true, :length => {:within => 6..40}, :on => :create
  validates :password, :length => {:within => 6..40}, :allow_blank => true, :on => :update
end


