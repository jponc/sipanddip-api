class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.string :slug, index: true, null: false
      t.string :name
      t.integer :restock_trigger_count, default: 1

      t.timestamps
    end
  end
end
