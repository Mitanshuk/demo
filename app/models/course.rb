class Course < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :title, presence: true
  validates :price, presence: true
end
