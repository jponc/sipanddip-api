class CreateInventoryItems < ActiveRecord::Migration[5.1]
  def change
    create_table :inventory_items do |t|
      t.integer :in_count
      t.integer :out_count
      t.integer :total_count

      t.timestamps
    end
  end
end
