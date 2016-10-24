class Merchant < ApplicationRecord
  has_many :products
  validates :email, :uid, :provider, presence: true
  
  def self.build_from_github(auth_hash)
    merchant           = Merchant.new
    merchant.uid       = auth_hash[:uid]
    merchant.provider  = 'github'
    merchant.user_name = auth_hash['info']['nickname']
    merchant.email     = auth_hash['info']['email']

    return merchant
  end

  # validates :email, :user_name, presence: true

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
