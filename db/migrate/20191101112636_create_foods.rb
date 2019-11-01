class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :kcal
      t.integer :serving
      t.integer :kj
      t.text :category
      t.text :group

      t.timestamps
    end
  end
end
