class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  has_many :orders, inverse_of: :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, length: { in: 3..20 }, presence: true

  before_save { self.admin = true unless User.any? }
end
