// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require materialize-sprockets
//= require materialize/extras/nouislider
//= require underscore
//= require gmaps/google
//= require geocomplete
//= require typeahead
//= require turbolinks
//= require_tree .

$(document).ready(function(){
  $('.modal-trigger').leanModal();
  $('.close').sideNav('hide');
  $(".button-collapse").sideNav({
    edge: 'right',
    menuWidth: 200,
    closeOnClick: true
  });
  $('select').material_select();
  var html5Slider = document.getElementById('html5');

  noUiSlider.create(html5Slider, {
    start: [ 600, 900 ],
    connect: true,
    range: {
      'min': 500,
      'max': 2500
    },
    margin: 50,
    step: 50
  });

  var gte = document.getElementById('higher');
  var lte= document.getElementById('lower');

  html5Slider.noUiSlider.on('update', function( values, handle ) {

    var value = values[handle];

    if ( handle ) {
      gte.value = Math.round(value);
    } else {
      lte.value = Math.round(value);
    }
  });

  lte.addEventListener('change', function(){
    html5Slider.noUiSlider.set([this.value, null]);
  });

  gte.addEventListener('change', function(){
    html5Slider.noUiSlider.set([null, this.value]);
  });
});


function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#img_prev')
        .attr('src', e.target.result)
        .removeClass('hidden')
        .height(250);
    };

    reader.readAsDataURL(input.files[0]);
  }
}