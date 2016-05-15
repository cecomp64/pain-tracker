class PainPoint < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  belongs_to :location

  validates_presence_of :user_id, :magnitude, :date
  validates_numericality_of :magnitude
end
