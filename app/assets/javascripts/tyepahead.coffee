# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

load_typeahead = ->
  # Find all typeahead boxes
  $('.typeahead').each (i, obj) ->
    # Find the data
    query = $(obj).data('query') # Search for more values
    prefetch = $(obj).data('prefetch') # Returns a json object with initial data
    value = $(obj).data('value') # Value to be used for form
    display = $(obj).data('display') # Value to be used for display
    name = $(obj).data('name') # Name...?

    console.log('name: ' + name)
    console.log('query: ' + query)
    console.log('prefetch: ' + prefetch)
    console.log('display: ' + display)
    console.log('value: ' + value)

    options = {
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace(display),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
    }

    options['prefetch'] = {url: prefetch, ttl: 1} if prefetch?
    #options['remote'] = {url: prefetch} if prefetch?
    #options['remote'] = {url: query+'?query=%QUERY', wildcard: '%QUERY'} if query?
    #options['remote'] = {url: prefetch+'?query=%QUERY', wildcard: '%QUERY'} if prefetch?

    data = new Bloodhound(options)

    # Show all options when the field is selected
    defaults = (q,sync) ->
      if q == ''
        sync(data.index.all())
      else
        data.search(q, sync)

    # Clear any caches
    localStorage.clear()

    # Initialize typeahead
    $(obj).typeahead({minLength: 0}, {name: name, display: display, source: defaults})

    console.log('Created typeahead')


$(document).ready(load_typeahead)
$(document).on('page:load', load_typeahead)
