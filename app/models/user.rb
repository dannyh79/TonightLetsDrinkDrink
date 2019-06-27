class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :weight, numericality: { greater_than: 0 }
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  # validates_uniqueness_of :email, message: '你的 Email 重複了'

  has_many :user_defines
end
