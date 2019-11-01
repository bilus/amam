json.extract! food, :id, :name, :kcal, :serving, :kj, :category, :group, :created_at, :updated_at
json.url food_url(food, format: :json)
