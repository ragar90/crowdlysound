jQuery ->
  $("#add_member_btn").on("body", "click", () ->
  	alert "Ha"
  	return
  )

  #$("#band_content").on "click", "input#add_member_btn", ->
  $("#add_member_btn").click ->
  	members = $('#add_member').val()
  	$.ajax
  		url: '/add_members/' + $('#add_member').data('band')
  		type: 'post'
  		data: {members: members} 
  		dataType: 'script'

  split = (val) ->
    val.split /,\s*/

  extractLast = (term) ->
    split(term).pop()
  
  $("#add_member").bind("keydown", (event) ->
    event.preventDefault()  if event.keyCode is $.ui.keyCode.TAB and $(this).data("ui-autocomplete").menu.active
  ).autocomplete
    source: (request, response) ->
      term = request.term
      if term of cache
      	response( cache[ term ] )
      	return

      $.getJSON "/find_musician/" + $("#add_member").data("band"), request, (data, status, xhr) ->
        cache[term] = data
        response data

    search: ->
      # custom minLength
      term = extractLast(@value)
      false  if term.length < 4

    focus: ->
      # prevent value inserted on focus
      false

    select: (event, ui) ->
      terms = split(@value)
      
      # remove the current input
      terms.pop()
      
      # add the selected item
      terms.push ui.item.value
      
      # add placeholder to get the comma-and-space at the end
      terms.push ""
      @value = terms.join(", ")
      false