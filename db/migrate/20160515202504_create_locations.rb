class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :area_id
      t.float :x_pos
      t.float :y_pos
      t.float :z_pos

      t.timestamps
    end
  end
end
