require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  test 'should not save recipe without a name' do
    recipe = Recipe.new
    assert_not recipe.save, 'saved recipe without a name'
  end
end
