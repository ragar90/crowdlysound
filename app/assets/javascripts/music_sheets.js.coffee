# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#note-btn").on "click", ->
    fret_val = $("#fret-input").val()
    string_val = $("#string-input").val()
    rest_val = $("#rest-input").val()
    duration_val = $("#duration-select").val()
    vextab_note = ""
    if rest_val is ""
      vextab_note = ":#{duration_val} ##{rest_val}#"
    else
      vextab_note = ":#{duration_val} #{fret_val}/#{string_val}"
    $(".vextab-composer .vex-tabdiv textarea.editor").val(vextab_note)
  $("#mute-input").on "click", ->
    console.log "ksksk"
