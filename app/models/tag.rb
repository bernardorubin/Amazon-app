class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :products, through: :taggings

  validates :name, presence: true, uniqueness: true
end
