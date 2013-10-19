jQuery ->  
  $("#instruments").bind("mousedown", (e) ->
    e.metaKey = true
  ).selectable stop: ->
      data = []
      $(".ui-selected", this).each -> 
        data.push $(this).data "insval"
      $.ajax
        url: '/save_instruments'
        type: 'post'
        data: {instruments: data}
        dataType: 'script'

  $("#genres").bind("mousedown", (e) ->
    e.metaKey = true
  ).selectable stop: ->
      data = []
      $(".ui-selected", this).each -> 
        data.push $(this).data "genval"
      $.ajax
        url: '/save_genres'
        type: 'post'
        data: {genres: data}
        dataType: 'script'