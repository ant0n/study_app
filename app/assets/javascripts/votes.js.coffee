# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  ready = ->
    $('.votes a').on 'click', (event) ->
      if $(this).hasClass('disabled')
        event.preventDefault()
        event.stopPropagation()

  $(document).ready(ready)
  $(document).on('page:load', ready)