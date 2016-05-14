class AddActivityToPainPoints < ActiveRecord::Migration
  def change
    add_column :pain_points, :activity, :integer
  end
end
