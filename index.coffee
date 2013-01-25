$(document).on 'ready', ->

  entropy = (charset_size, length) ->
    length * ( Math.log(charset_size)/Math.log(2) )

  ###
  Password Entropy Stuff
  ###
  
  $entropy_slider = $('#entropy_slider_input')
  $entropy_text   = $('#entropy_text_input')

  set_entropy = (value) ->
    rounded = Math.round(value*100)/100
    $entropy_text.val rounded
    $entropy_slider.val rounded

  update_entropy = ->
    charset_length  = charset_text_value().length
    password_length = parseInt($length_text.val())
    e = entropy charset_length, password_length
    set_entropy e

  set_entropy '100'

  $entropy_slider.change ->
    set_entropy $entropy_slider.val()

  $entropy_text.change ->
    set_entropy $entropy_slider.val()


  ###
  Passowrd Length Stuff
  ###

  $length_slider = $('#length_slider_input')
  $length_text   = $('#length_text_input')

  set_length = (value) ->
    $length_text.val value
    $length_slider.val value

  set_length '20'

  $length_slider.change ->
    set_length $length_slider.val()

  $length_text.change ->
    set_length $length_slider.val()

  $('#length input').on 'change keypress paste focus textInput input', update_entropy


  ###
  Charset Stuff
  ###

  $charset_text = $('#charset_text_input')
  $charset_length_text = $('#charset_length_text_input')

  charset_text_value = ->
    out = _.uniq( c for c in $charset_text.val() )
    out

  set_charset_text = (value) ->
    $charset_text.val(value)
    update_charset_length_text()
    update_entropy()

  set_charset_length_text = (length) ->
    $charset_length_text.val length

  update_charset_length_text = ->
    set_charset_length_text charset_text_value().length

  update_charset_length_text()

  selected_charset = ->
    $(el).val() for el in $('#charset_selector .char-checkbox-container :checked')

  update_charset_text = ->
    set_charset_text selected_charset().join('')

  update_charset_text()

  set_charset_selector = (chars) ->
    $(".char-checkbox").each ->
      checked = $(this).val() in chars
      $(this).prop 'checked', checked

  update_charset_selector = ->
    set_charset_selector charset_text_value()

  $charset_text.on 'change keypress paste focus textInput input', ->
    update_charset_length_text()
    update_charset_selector()

  $('#charset input').on 'change keypress paste focus textInput input', update_entropy

  $('.char-checkbox-container .checkbox').change update_charset_text

  $('.row-checkbox').change ->
    checked = $(this).prop('checked')
    $(this).parent().find('.char-checkbox-container .checkbox').each ->
      $(this).prop 'checked', checked
    update_charset_text()


  ###
  Password Generation
  ###

  rand_int = (max) ->
    Math.floor(Math.random() * max)

  get_password = ->
    length = parseInt $length_text.val()
    charset = charset_text_value()
    charset_length = charset.length

    out = ( charset[rand_int(charset_length)] for x in [0...length] )
    out.join('')

  $('#generate').click ->
    $('#generated_password').val get_password()








    