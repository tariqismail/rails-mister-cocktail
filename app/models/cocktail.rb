class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
