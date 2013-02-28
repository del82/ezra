# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
	confirmed = $('#selections').attr("data-loaded")
	$('.status-box').tooltip()
	$('[data-value='+confirmed+']').addClass('selected')
	parseLocation($('#location').attr("data-value"))


parseLocation = (time) ->
	$('#location').html(time)