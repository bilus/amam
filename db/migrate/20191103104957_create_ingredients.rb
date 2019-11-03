class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.belongs_to :recipe
      t.belongs_to :food
      t.integer :serving

      t.timestamps
    end
  end
end
