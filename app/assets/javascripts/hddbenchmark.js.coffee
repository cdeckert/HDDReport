# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

resultURL = ->
	document.location.href+'/results'


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
	series:[
		name: "data"
		data: []
	]
	xAxis:
		events:
			afterSetExtremes : afterSetExtremes


drawchart = ->
	#get result
	$.getJSON resultURL(), (data)->
		rawChart.series[0].data = data
		$("#container").highcharts(rawChart)

$(document).ready ->
	drawchart() if $("#container").length > 0