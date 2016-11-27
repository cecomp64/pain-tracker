module PainPointsHelper
  def str_to_date(s)
    date = nil

    begin
      # Try javascript date format first
      date = DateTime.strptime(s, '%m/%d/%Y %H:%M %p').change(offset: Time.current.zone)
    rescue
      # Try serialized DateTime next
      date = DateTime.strptime(s).change(offset: Time.current.zone)
    end

    return date
  end
end
