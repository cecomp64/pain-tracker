class Location < ActiveRecord::Base
  validates_uniqueness_of :name
  validates :name, uniqueness: {scope: :area_id}, presence: true
end
