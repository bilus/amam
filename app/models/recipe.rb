class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :foods, through: :ingredients

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: ->(attr) { attr['food_id'].nil? }
end
