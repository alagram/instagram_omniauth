class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
        :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:instagram]

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(uid: auth_hash[:uid]).first

    if user
      user.profile_picture = auth_hash[:info][:image]
      user.settings["token"] = auth_hash[:credentials][:token]
      user.save!
    else
      user = User.create!(
        name: auth_hash[:info][:name],
        uid: auth_hash[:uid],
        email: dummy_email(auth_hash),
        password: Devise.friendly_token,
        profile_picture: auth_hash[:info][:image],
        settings: { token: auth_hash[:credentials][:token] }
      )
    end

    user
  end

  def self.dummy_email(auth_hash)
    "#{auth_hash[:uid]}_#{auth_hash[:provider]}@example.com"
  end
end
