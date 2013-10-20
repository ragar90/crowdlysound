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

  $("#genres.clickiable_genres").bind("mousedown", (e) ->
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

  $("#follow_user.page_instrument").on "click", "a", ->
    follow = $(this).data "follow"
    musician_id = $("#follow_musician_id").val()
    $.ajax
      url: "/follow_user"
      type: "get"
      data: {follow: follow, musician_id: musician_id}
      dataType: 'script'