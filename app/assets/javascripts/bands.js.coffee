jQuery ->  
  log = (message) ->
  	$("<div>").text(message).prependTo "#log"
  	$("#log").scrollTop 0

  $("#add_member").autocomplete
    source: "/find_musician"
    minLength: 4
    select: (event, ui) ->
      log (if ui.item then "Selected: " + ui.item.value + " aka " + ui.item.id else "Nothing selected, input was " + @value)