class KcMap
  constructor: (@json) ->
    @data = @json.data
    console.log @data

  prepare_data: (@json) ->
    # ["il","34.9888","31.7496","/images/balls/il.png",1]
    @coords_by_country = {}
    (@coords_by_country[country] ||= []).push [lat, long] for [country, lat, long, _ball, _num] in @data

    console.log @coords_by_country

    @postcount_by_country = for country, list of @coords_by_country
      {country: country, size: list.length}

    console.log @postcount_by_country


  present_data: ->
    slice @postcount_by_country #[{country: 'il', size: 9000}]


$(document).ready ->
  console.log "Init"

  $.getJSON 'http://krautchan.net/ajax/geoip/lasthour', (data) ->
    console.log "Getting data"

    map = new KcMap(data)
    map.prepare_data()
    map.present_data()