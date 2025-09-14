class AddColumnsToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :time, :string
    add_column :recipes, :serving, :string
    add_column :recipes, :type, :string
  end
end
