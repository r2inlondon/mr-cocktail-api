class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :description
      t.references :cocktail, null: false, foreign_key: true

      t.timestamps
    end
  end
end
