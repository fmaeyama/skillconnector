# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$(document).on 'turbolinks:load', ->

	$('form').on 'click', '.remove_fields', (event) ->
		model = $(this).attr('data-model')
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('.'+model+'_input').hide()
		event.preventDefault()

	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		model = $(this).attr('data-model')
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).closest('.key_'+model+'_holder').children('.'+model+'_holder').append($(this).data('fields').replace(regexp,time))
		event.preventDefault()
