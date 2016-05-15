json.array!(@locations) do |location|
  json.extract! location, :id, :name, :area_id, :x_pos, :y_pos, :z_pos
  json.url location_url(location, format: :json)
end
