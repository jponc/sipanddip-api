class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.string :slug
      t.string :name
      t.integer :restock_trigger_count

      t.timestamps
    end
  end
end
