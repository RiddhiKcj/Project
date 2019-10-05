class User < ApplicationRecord
  has_secure_password
  has_many :selectedwidgets , dependent: :destroy
  geocoded_by :current_sign_in_ip
  after_validation :geocode, if: :current_sign_in_ip_changed?
  
end


