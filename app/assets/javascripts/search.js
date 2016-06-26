$(document).on('ready page:load', function(){
  $('#city').typeahead({
    name: "listing",
    displayKey: 'city',
    remote: "/listings/autocomplete?query=%QUERY"
  });

  $('.tt-hint').addClass('form-control');


});