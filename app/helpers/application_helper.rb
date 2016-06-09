module ApplicationHelper
  def date_format(date)
    date.strftime('%h %d, %Y %H:%M %Z')
  end

  def filter_title_for(item, filters)
    return '' if filters.nil?
    titles = filters.map do |filter, value|
      func = filter.sub('_id', '')
      if item.respond_to?(func)
        if item.send(func).respond_to?(:name)
          item.send(func).send(:name).titleize
        else
          ''
        end
      end
    end

    return titles.select{|t| t!= nil}.join(',')
  end

  def chart_or_banner(data, chart)
    if data.empty?
      banner = '<div class="no-data">No Data Available</div>'
      return banner.html_safe
    end

    return chart
  end
end
