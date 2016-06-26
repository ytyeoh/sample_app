  $('#city').typeahead({
    name: "listing",
    displayKey: 'city',
    remote: "/listings/autocomplete?query=%QUERY"
  });
