// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {
  $('.star-rating').raty({
    path: '/assets',
    readOnly: function() {
      var attr = $(this).data('read-only');

      if (attr === undefined) {
        return false;
      } else {
        return !!attr;
      }
    },
    scoreName: function() {
      return $(this).data('name');
    },
    score: function() {
      return $(this).data('score');
    }
  });
});
