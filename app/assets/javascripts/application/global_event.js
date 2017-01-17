var globalEvent = {
  initialize: function() {
    this.flashAjax();
    this.likeUnlikeAjax();
    this.paymentHide();
    // this.infiniteScroll();
  },

  flashAjax: function() {
    $(document).ajaxSuccess(function(event, request) {
      var flashMessageHTML, msg;
      if (request.getResponseHeader('X-Message')){
        msg = request.getResponseHeader('X-Message');
      }
      else if (request.responseText.length > 100 || request.responseText.includes("[")){
        msg === null;
      }
      else{
        msg = request.responseText;
      }

      if (msg) {

        msg = msg.replace(/"/g, '');
        Materialize.toast( msg +'<span><i class="material-icons">clear</i></span>' , 3000);
      }
    });
  },

  paymentHide: function() {
    $('input[type=radio]').change(function() {
      $('#payment-form').removeClass('hide');
      $('.submit-btn').removeClass('hide');
      $('.value').empty();
      var x = $('input[type=radio]:checked').val();
      var id = this.id;
      var y = document.getElementsByClassName(id)[0].innerHTML;
      var msg = 'Credit:' + x + '<br>  Total Paid   '+ y;
      $('.value').append(msg);
    });
  },

  likeUnlikeAjax: function() {
    $('.like-listing').bind('ajax:success', function(data, status, xhr) {
      var currentFavCount, newFavCount, targetFavCount, targetFavCountParent, targetParent;
      targetFavCountParent = $(this).parent().parent();
      targetFavCount = $('.fav-count', targetFavCountParent);
      currentFavCount = parseInt(targetFavCount.html(), 10);
      targetParent = $(this).parent();
      newFavCount = currentFavCount + 1;
      $(this).addClass('hide');
      $('.unlike-listing', targetParent).removeClass('hide');
      targetFavCount.html(newFavCount);
      currentFavCount = newFavCount;
    });
    $('.unlike-listing').bind('ajax:success', function(data, status, xhr) {
      var currentFavCount, newFavCount, targetFavCount, targetFavCountParent, targetParent;
      targetFavCountParent = $(this).parent().parent();
      targetFavCount = $('.fav-count', targetFavCountParent);
      currentFavCount = parseInt(targetFavCount.html(), 10);
      targetParent = $(this).parent();
      newFavCount = currentFavCount - 1;
      
      $(this).addClass('hide');
      $('.like-listing', targetParent).removeClass('hide');
      targetFavCount.html(newFavCount);
      currentFavCount = newFavCount;
    });
  },
  // infiniteScroll: function() {
  //   $(".infinite-wrapper").infinitescroll({
  //     navSelector: ".infinite-pagination .pagination",
  //     nextSelector: ".infinite-pagination .pagination a[rel=next]",
  //     itemSelector: ".infinite-index .infinite-item",
  //     animation: true,
  //     loading: {
  //       msgText: "<em>Loading more...</em>",
  //       // img: image_path('loading.gif')
  //     }
  //   }, function(arrayOfNewElems) {
  //     if ($("img.unveil").length) {
  //       return $("img.unveil").unveil(200, function() {
  //         return $(this).load(function() {
  //           return this.style.opacity = 1;
  //         });
  //       });
  //     }
  //   });
  // }
}