# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$(document).on 'turbolinks:load', ->

	$('form').on 'click', '.hat_remove_fields', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('.hat_input').hide()
		event.preventDefault()

	$('form').on 'click', '.hat_add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).closest('.key_hat_holder').children('.hat_holder').append($(this).data('fields').replace(regexp,time))
		event.preventDefault()
