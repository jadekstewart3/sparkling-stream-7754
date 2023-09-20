require "rails_helper"

RSpec.describe Ingredient, type: :model do

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :cost }
  end

  describe "relationships" do
    it { should have_many :recipe_ingredients }
    it { should have_many(:recipes).through(:recipe_ingredients) }
  end
  
  before do 
    @tacos = Recipe.create!(name: "Tacos", complexity: 2, genre: "Tex-mex") 

    @ground_beef = Ingredient.create!(name: "Ground Beef", cost: 6) 
    @garlic = Ingredient.create!(name: "Garlic", cost: 1) 
    @salsa = Ingredient.create!(name: "Salsa", cost: 2) 
    @cheese = Ingredient.create!(name: "Cheese", cost: 4) 

    RecipeIngredient.create!(recipe: @tacos, ingredient: @ground_beef)
    RecipeIngredient.create!(recipe: @tacos, ingredient: @garlic)
    RecipeIngredient.create!(recipe: @tacos, ingredient: @salsa)
    RecipeIngredient.create!(recipe: @tacos, ingredient: @cheese)
  end
  describe "total_cost" do

    it "returns the total cost of all of a recipes ingredients" do 
      expect(@tacos.ingredients.total_cost).to eq(13)

      lettuce = Ingredient.create!(name: "Lettuce", cost: 1)
      RecipeIngredient.create!(recipe: @tacos, ingredient: lettuce)
      
      expect(@tacos.ingredients.total_cost).to eq(14)
    end

    it "sorts all ingredients alphabetically by name" do 
      expect(@tacos.ingredients.sort_alphabetically).to eq([@cheese, @garlic, @ground_beef, @salsa])
    end
  end

end