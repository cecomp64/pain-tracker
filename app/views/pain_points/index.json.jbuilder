json.array!(@pain_points) do |pain_point|
  json.extract! pain_point, :id, :user_id, :magnitude, :notes, :location_id
  json.url pain_point_url(pain_point, format: :json)
end
