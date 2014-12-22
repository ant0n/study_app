# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  ready = ->
    $('.add_answer').click (e) ->
      e.preventDefault()
      $('#new_answer').show()

    $('.actions .edit').click (e) ->
      e.preventDefault()
      answer_id = $(this).data('answer-id')
      $('#edit_answer_'+answer_id).show()


  $(document).ready(ready)
  $(document).on('page:load', ready)