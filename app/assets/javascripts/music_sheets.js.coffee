# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#note-btn").on "click", (e) ->
    e.preventDefault()
    fret_val = $("#fret-input").val()
    string_val = $("#string-input").val()
    rest_val = $("#rest-input").val()
    duration_val = $("#duration-select").val()
    vextab_note = ""
    console.log rest_val
    if rest_val != "" and rest_val != "0"
      vextab_note = ":#{duration_val} ##{rest_val}#"
    else if $("#fret-input").attr("disabled") is "disabled"
      vextab_note = ":#{duration_val} X/#{string_val}"
    else
      vextab_note = ":#{duration_val} #{fret_val}/#{string_val}"
    actual_val = $(".vextab-composer .vex-tabdiv textarea.editor").val()
    if actual_val.indexOf("notes") < 0
      actual_val += "\nnotes #{vextab_note}"
    else
      actual_val += " #{vextab_note}"

    $(".vextab-composer .vex-tabdiv textarea.editor").val(actual_val)
    $("#music_sheet_notes").val(actual_val)
    $(".vextab-composer .vex-tabdiv textarea.editor").keyup()

  $("#mute-input").on "click", ->
    checked = $(@).data("checked")
    if checked == false
      $("#fret-input").prop('disabled', true);
      $("#fret-input").val("")
      checked = $(@).data("checked",true)
    else
      $("#fret-input").val("")
      $("#fret-input").removeAttr("disabled")
      checked = $(@).data("checked",false)

  $("#chord-btn").on "click", (e) ->
    e.preventDefault()
    chords_val = $("#chords-select").val()
    actual_val = $(".vextab-composer .vex-tabdiv textarea.editor").val()
    if actual_val.indexOf("notes") < 0
      actual_val += "\nnotes #{chords_val}"
    else
      actual_val += " #{chords_val}"
    $(".vextab-composer .vex-tabdiv textarea.editor").val(actual_val)
    $("#music_sheet_notes").val(actual_val)
    $(".vextab-composer .vex-tabdiv textarea.editor").keyup()

  $("#bar-btn").on "click", (e) ->
    e.preventDefault()
    bar_val = $("#bar-select").val()
    actual_val = $(".vextab-composer .vex-tabdiv textarea.editor").val()
    if actual_val.indexOf("notes") < 0
      actual_val += "\nnotes #{bar_val}"
    else
      actual_val += " #{bar_val}"
    $(".vextab-composer .vex-tabdiv textarea.editor").val(actual_val)
    $("#music_sheet_notes").val(actual_val)
    $(".vextab-composer .vex-tabdiv textarea.editor").keyup()