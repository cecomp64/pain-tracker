class Activity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :name
  validates :name, :uniqueness => {:scope => :user_id}
end
