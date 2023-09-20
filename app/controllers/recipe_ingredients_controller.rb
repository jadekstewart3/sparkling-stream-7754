class RecipeIngredientsController < ApplicationController
  
  def create
    recipe_ingredient = RecipeIngredient.new(recipe_id: params[:id], ingredient_id: params[:new_ingredient])
    redirect_to "/recipes/#{recipe_ingredient.recipe_id}"
    if recipe_ingredient.save!
      flash[:success] = "Added Ingredient!"
    else
      flash[:error] = "Error: #{error_message(recipe_ingredient.errors)}"
    end
  end
end