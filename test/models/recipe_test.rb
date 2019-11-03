require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  setup do
    @food1 = foods(:one)
    @food2 = foods(:two)
  end

  test "should save recipe without title" do
    recipe = Recipe.new
    assert recipe.save
  end

  test "should accept ingredients as nested attributes" do
    params = {
      recipe: {
        ingredients_attributes: [
          { food_id: @food1.id },
          { food_id: @food2.id },
        ],
      },
    }
    recipe = Recipe.new(params[:recipe])
    assert recipe.ingredients.length == 2
    assert recipe.ingredients.map(&:food).map(&:id).sort == [@food1, @food2].map(&:id).sort
    assert recipe.save
  end
end
