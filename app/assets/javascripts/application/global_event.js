var globalEvent = {
  initialize: function() {
    this.likeUnlikeAjax();

    Dropzone.options.newReview = {
      paramName: "listing[image]",
      autoProcessQueue: false,
      uploadMultiple: true,
      parallelUploads: 100,
      maxFiles: 100,
      addRemoveLinks: true,
      previewsContainer: ".dropzone-previews",
      clickable: ".dropzone-btn",
      thumbnailHeight: 50,
      dictRemoveFile: "Remove",
      hiddenInputContainer: ".hidden-input-container",
      dictCancelUpload: "Uploading...",
      maxFilesize: 3,
      init: function(file, done) {
        var myDropzone = this
        myDropzone.on("addedfile", function(file) {
          this.element.querySelector("input[type=submit]").addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation();
            submitButton.init();
            myDropzone.processQueue();
            $(this).val("Submitting...");
            submitButton.disable();
          });
        });
        myDropzone.on("dragover", function(event) {
          $(".new-review-wrapper").addClass("active");
        });
        myDropzone.on("dragleave", function(event) {
          $(".new-review-wrapper").removeClass("active");
        });
        myDropzone.on("drop", function(event) {
          $(".new-review-wrapper").removeClass("active");
        });
        myDropzone.on("queuecomplete", function(file) {
          submitButton.enable();
          window.location.reload();
        });
      }
    }
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