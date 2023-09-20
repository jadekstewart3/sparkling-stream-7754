require "rails_helper"

RSpec.describe Ingredient, type: :feature do 
  let!(:ground_beef) { Ingredient.create!(name: "Ground Beef", cost: 6) }
  let!(:garlic) { Ingredient.create!(name: "Garlic", cost: 1) }

  context "As a visitor, when I visit the ingredients index" do 
    it "I see a list of all of the ingredients and their cost" do
      visit ingredients_path
      expect(page).to have_content("Ground Beef: 6")
      expect(page).to have_content("Garlic: 1")
    end

    it "I see that all of the ingredients are sorted alphabetically" do 
      visit ingredients_path

      expect("Garlic").to appear_before("Ground Beef")
    end
  end
end