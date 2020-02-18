# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_defines
  has_one  :identity, dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: %i[google_oauth2]
  # omniauth_providers: %i[google_oauth2 facebook]

  validates :weight,             numericality: { greater_than: 0 }
  validates :email,              presence: true
  validates :encrypted_password, presence: true
  validates :weight,             presence: true
  validates :email,              uniqueness: true
  validates_format_of :email,
                      with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([a-zA-Z]{2,})\z/i
  # password
  # validates :password, length: { minimum: 6 }

  def self.from_omniauth(auth, signed_in_resource = nil)
    # data = access_token.info
    identity = Identity.find_for_auth(auth)
    user = signed_in_resource || identity.user

    # FIXME: Nested if statement
    if user.nil?
      email = auth.info.email

      user = User.where(email: email).first if email

      # FIXME: Auth flow & user story for registration
      if user.nil?
        user = User.new(email: auth.info.email,
                        # user.gender = auth.extra.raw_info.gender
                        # gender: auth.info.gender,
                        # weight: auth.info.weight,  # google 沒有體重欄，可能要再想一下...
                        # name: auth.info.name.gsub(/\s+/, '_'),
                        password: Devise.friendly_token[0, 20])

        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end

  def delete_access_token(auth)
    @graph.delete_connections(auth.uid, "permissions")
  end

  def from_3rd_party_login?
    Identity.find_by(user_id: id).present?
  end
end
