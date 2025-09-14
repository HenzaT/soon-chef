class AddLinkToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :link, :text
  end
end
