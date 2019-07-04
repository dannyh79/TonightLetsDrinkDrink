class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_defines

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :encrypted_password, :gender, :weight, presence: true

  # email
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([a-zA-Z]{2,})\z/i
  validates :email, uniqueness: true

  # password
  validates :password, length: { minimum: 6 }

  # weight
  validates :weight, numericality: { greater_than: 0 }

end
