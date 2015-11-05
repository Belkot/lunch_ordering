class Order < ActiveRecord::Base
  belongs_to :user, inverse_of: :orders
  has_many :line_items
  has_many :courses, through: :line_items
end
