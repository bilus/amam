require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  test "should not save food without name" do
    food = Food.new
    assert_not food.save
  end

  test "should save valid food" do
    food = Food.new
    food.name = "foo bar"
    assert food.save
  end
end
