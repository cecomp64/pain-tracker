module ApplicationHelper
  def date_format(date)
    date.strftime('%h %d, %Y %H:%M %Z')
  end
end
