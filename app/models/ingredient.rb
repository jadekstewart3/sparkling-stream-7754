class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
   
  validates_presence_of :name, :cost

  scope :total_cost, -> { sum(:cost) }

  scope :sort_alphabetically, -> { order(:name) }
end