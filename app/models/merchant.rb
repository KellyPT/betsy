class Merchant < ApplicationRecord
  has_many :products
  validates :email, :user_name, presence: true
  
  #  :uid, :provider,
  # def self.build_from_github(auth_hash)
  #   user          = User.new
  #   user.uid      = auth_hash[:uid]
  #   user.provider = 'github'
  #   user.name     = auth_hash['info']['name']
  #   user.email    = auth_hash['info']['email']
  #
  #   return user
  # end

end
