class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.text :name
      t.text :ingredients
      t.text :method
      t.text :image
      t.text :note
      t.integer :rating

      t.timestamps
    end
  end
end
