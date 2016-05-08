class CreatePainPoints < ActiveRecord::Migration
  def change
    create_table :pain_points do |t|
      t.integer :user_id
      t.float :magnitude
      t.text :notes
      t.integer :location_id

      t.timestamps
    end
  end
end
