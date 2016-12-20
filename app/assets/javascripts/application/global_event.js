var globalEvent = {
  initialize: function() {
    this.flashAjax();
    this.likeUnlikeAjax();
  },

  flashAjax: function() {
    $(document).ajaxSuccess(function(event, request) {
      var flashMessageHTML, msg;
      msg = request.responseText;
      msg = msg.replace(/"/g, '');
      if (msg) {
        Materialize.toast( msg +'<span><i class="material-icons">clear</i></span>' , 3000);
      }
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

}