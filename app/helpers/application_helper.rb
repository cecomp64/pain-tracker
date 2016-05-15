module ApplicationHelper
  def date_format(date)
    date.strftime('%h %d, %Y %H:%M %Z')
  end

  def filter_title_for(item)
    return '' if @filters.nil?
    titles = @filters.map do |filter, value|
      func = filter.sub('_id', '')
      if item.respond_to?(func)
        if item.send(func).respond_to?(:name)
          item.send(func).send(:name)
        else
          ''
        end
      end
    end

    return titles.join(',')
  end
end
