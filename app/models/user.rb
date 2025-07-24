class User < ApplicationRecord
   has_many :products
    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable,:omniauthable,  jwt_revocation_strategy: self,
        omniauth_providers: [:google_oauth2]

# def  jwt_payload
#  super
# end

def self.from_omniauth(auth)
  if auth.nil?
    Rails.logger.error "Omniauth auth hash is nil!"
    return nil
  end
  Rails.logger.debug "shyammmmmmmm_auth#{auth.inspect}"
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
  end
end
end 
