# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  #$('.edit-answer-link').click (e) ->
  #  e.preventDefault();
  #  $(this).hide();
  #  answer_id = $(this).data('answerId')
  #  $('form#edit-answer-' + answer_id).show()

  $('form#new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $('.answers').append(JST['template/answer'](answer: answer))
    $(this).find('.has-error').removeClass('has-error')
    $(this).find('.help-block').remove()
    $(this).find('textarea').val('')
    $(this).hide()
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('#new_answer .answer_body').addClass('has-error').append('<span class="help-block">'+value["body"]+'</span>')