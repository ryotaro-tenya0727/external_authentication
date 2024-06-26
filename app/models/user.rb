class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github line]
  has_one :authorization, dependent: :destroy

  def self.from_omniauth(auth)
    authorization = Authorization.find_by(provider: auth.provider, uid: auth.uid)
    if authorization
      user = authorization.user
      user.update(name: auth.info.name, email: auth.info.email, image_url: auth.info.image)
    else
      if auth.info.email.blank?
        email = "test@email.com"
      else
        email = auth.info.email
      end
      user = User.create(name: auth.info.name, email: email, image_url: auth.info.image, password: Devise.friendly_token[0, 20])
      user.create_authorization(provider: auth.provider, uid: auth.uid)
    end
    user
  end
end
