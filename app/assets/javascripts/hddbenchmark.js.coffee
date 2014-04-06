# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

resultURL = ->
	document.location.href+'/results'

minURL = ->
	document.location.href+'/min'
avgURL = ->
	document.location.href+'/avg'

afterSetExtremes = (e)->
	url = resultURL()
	url+="?from="+e.min+"&to="+e.max
	chart = $("#container").highcharts()
	chart.showLoading('Loading data from server...');

	$.getJSON url, (data)->
		chart.series[0].setData data
		chart.hideLoading()

rawChart = 
	chart:
		zoomType: "x"
		renderTo: "container"
	plotOptions:
		series:
			marker:
				enabled: false
	series:[
		{
		name: "data"
		data: []
		}
		{
		name: "min"
		data: []
		}
		{
		name: "avg"
		data: []
		}

	]
	xAxis:
		events:
			afterSetExtremes : afterSetExtremes


drawchart = ->
	
	$.getJSON resultURL(), (data)->
		rawChart.series[0].data = data
		theChart = new Highcharts.Chart rawChart
		console.log theChart


		$.getJSON minURL(), (data) ->
			theChart.series[1].setData data

		$.getJSON avgURL(), (data) ->
			theChart.series[2].setData data


ready = ->
	drawchart() if $("#container").length > 0

$(document).ready(ready)
$(document).on('page:load', ready)
