class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name

      t.timestamps
    end

    add_index(:pain_points, :user_id)
    add_column(:pain_points, :activity_id, :integer)
    add_index(:pain_points, :activity_id)

    # User habtm activities
    create_join_table :activities, :users
  end
end
