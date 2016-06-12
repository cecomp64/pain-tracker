require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PainTracker
  # Some useful Constants
  PIE_CHART_NO_LEGEND = {plotOptions: {pie: {dataLabels: {enabled: false}, showInLegend: false}}}
  LINE_CHART_DUAL_AXIS = {yAxis: [{title: {text: 'Pain Magnitude', style: {color: 'Highcharts.getOptions().colors[0]'}}},
                                  {title: {text: 'Amount of Activity', style: {color: 'Highcharts.getOptions().colors[1]'}}, opposite: true,
                                   labels: {format: '{value}'}}],
                          tooltip: {shared: true}}

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end

module ActiveRecord
  class Relation
    # filter
    #
    # Use the input active record query, and append a filter to it based on the filters present in params
    def filter(filters)
      return self if filters.nil?
      filtered_query = self
      filters.each do |field, value|
        parsed_value = value == '' ? nil : value
        field_s = field.to_s
        min_max_match =  /(min_)|(max_)/.match(field_s)

        # Handle ranges of values
        if min_max_match
          # Make sure there's a valid field here
          mf = field_s.sub('min_','').sub('max_','').strip
          next if mf.empty?

          # Figure out if this is a min or max
          min = min_max_match[1]
          mfield = PainPoint.arel_table[mf]
          filtered_query = min ? filtered_query.where(mfield.gteq(value)) : filtered_query.where(mfield.lteq(value))
        else
          # Handle equality
          filtered_query = filtered_query.where(field_s => parsed_value)
        end
      end

      @filters = filters
      return filtered_query
    end
  end
end

class Hash
  def titleize
    return self.map{|k,v| "#{k.to_s.titleize}"}.join(' ')
  end

  def subtitle
    title = '{'
    title += self.map{|k,v| "#{k}: #{v}"}.join(', ')
    return title + '}'
  end
end
