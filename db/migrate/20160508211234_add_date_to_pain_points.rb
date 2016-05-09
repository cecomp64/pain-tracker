class AddDateToPainPoints < ActiveRecord::Migration
  def change
    add_column :pain_points, :date, :datetime
  end
end
