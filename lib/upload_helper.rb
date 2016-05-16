require 'csv'

class UploadHelper
  def self.pain_points_csv(file, user)
    # Check input file
    return {error: "File not specified"}  if file.nil?

    # Try to parse the CSV
    csv = nil
    begin
      csv = CSV.new(File.read(file), headers: true, header_converters: :symbol)
    rescue
      return {error: "File is not a CSV"}
    end

    # Make sure we can get a hash
    begin
      csv_hash = csv.to_a.map {|row| row.to_hash}
    rescue
      return {error: "File has some unsupported characters.  Please make sure it is in UTF-8 format."}
    end

    pain_points = []
    csv_hash.each do |line|
      date = DateTime.strptime(line[:date], '%m/%d/%Y') if(line[:date])
      activity = Activity.find_or_create_by(name: line[:activity], user: user)
      magnitude = line[:pain] || 0
      location = Location.find_or_create_by(name: line[:location]) if(line[:location])
      notes = line[:notes]

      pain_points << PainPoint.create(date: date, activity: activity, magnitude: magnitude, location: location, notes:
          notes, user: user)
    end

    return pain_points
  end
end