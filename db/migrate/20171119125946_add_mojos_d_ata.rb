class AddMojosDAta < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_records, :mojos_count, :integer, default: 0
  end
end
