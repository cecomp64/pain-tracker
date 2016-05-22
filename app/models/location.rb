class Location < ActiveRecord::Base
  validates :name, uniqueness: {scope: :area_id}, presence: true
end
