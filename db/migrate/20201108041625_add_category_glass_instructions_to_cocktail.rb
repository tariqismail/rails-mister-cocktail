class AddCategoryGlassInstructionsToCocktail < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :category, :string
    add_column :cocktails, :glass, :string
    add_column :cocktails, :instructions, :text
  end
end
