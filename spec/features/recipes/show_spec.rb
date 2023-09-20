require "rails_helper"

RSpec.describe Recipe, type: :feature do 

  let!(:tacos) { Recipe.create!(name: "Tacos", complexity: 2, genre: "Tex-mex") }

  let!(:ground_beef) { Ingredient.create!(name: "Ground Beef", cost: 6) }
  let!(:garlic) { Ingredient.create!(name: "Garlic", cost: 1) }
  let!(:salsa) { Ingredient.create!(name: "Salsa", cost: 2) }
  let!(:cheese) { Ingredient.create!(name: "Cheese", cost: 4) }
  let!(:tomato) { Ingredient.create!(name: "Tomato", cost: 1) }

  before do 
    RecipeIngredient.create!(recipe: tacos, ingredient: ground_beef)
    RecipeIngredient.create!(recipe: tacos, ingredient: garlic)
    RecipeIngredient.create!(recipe: tacos, ingredient: salsa)
    RecipeIngredient.create!(recipe: tacos, ingredient: cheese)
  end

  context "As a visitor, when I visit the recipe show page" do 
    it "displays the recipies attributes and the recipes ingredients" do
      visit "/recipes/#{tacos.id}"
      expect(page).to have_content("Tacos")
      expect(page).to have_content("Complexity: 2")
      expect(page).to have_content("Genre: Tex-mex")
      expect(page).to have_content("Ingredients:")
      expect(page).to have_content("Ground Beef")
      expect(page).to have_content("Garlic")
      expect(page).to have_content("Salsa")
      expect(page).to have_content("Cheese")
    end

    it "diplays the total cost of all of the ingredients listed" do 
      visit "/recipes/#{tacos.id}"

      expect(page).to have_content("Total Cost: $13")
    end

    it "displays a form to add an ingredient to a recipe" do 
      visit "/recipes/#{tacos.id}"

      expect(page).to have_content("Add Ingredient")
      
      fill_in :new_ingredient, with: tomato.id

      click_on "Submit"

      expect(page).to have_content("Tomato")
      expect(page).to have_content("Total Cost: $14")
    end
  end
end