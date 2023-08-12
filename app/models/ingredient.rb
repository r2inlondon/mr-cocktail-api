class Ingredient < ApplicationRecord
  validates :description, presence: true

  belongs_to :cocktail
end
