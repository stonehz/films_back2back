# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # enable chosen js
  $('[data-behaviour~=timepicker]').timepicker
    template: false
    showInputs: false
    minuteStep: 10
    defaultTime: 'current'
    showMeridian: false
  $('[data-behaviour~=datepicker]').datepicker
    format: "yyyy/mm/dd"
    autoclose: true
    todayHighlight: true
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '200px'