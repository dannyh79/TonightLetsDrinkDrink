class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :weight, numericality: { greater_than: 0 }
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\A]{2,6}$)\z/i

  has_many :user_defines
end
