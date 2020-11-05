class Ingredient < ApplicationRecord
  # has_one_attached :photo
  has_many :doses

  validates :name, presence: true, uniqueness: true
end
