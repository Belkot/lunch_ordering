class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  has_many :orders, inverse_of: :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, length: { in: 3..20 }

  before_save { self.admin = true unless User.any? }

  # validates_presence_of   :avatar
  # validates_integrity_of  :avatar
  # validates_processing_of :avatar

end
