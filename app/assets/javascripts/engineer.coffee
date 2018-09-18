# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$(document).on 'turbolinks:load', ->

	$('form').on 'click', '.career_remove_fields', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('.career_input').hide()
		event.preventDefault()

	$('form').on 'click', '.career_add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$('.career_holder').append($(this).data('fields').replace(regexp, time))
		event.preventDefault()

	$('form').on 'click', '.engineer_hope_business_remove_fields', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('.engineer_hope_business_input').hide()
		event.preventDefault()

	$('form').on 'click', '.engineer_hope_business_add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$('.engineer_hope_business_holder').append($(this).data('fields').replace(regexp, time))
		event.preventDefault()

	@