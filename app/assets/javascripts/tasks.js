$(document).on('turbolinks:load', function() {
  $('#task-completion-modal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var taskId = button.data('task-id');
    $('#task-completion-modal .input-completion-token').val('');

    $('#task-completion-modal form').attr('action', '/tasks/' + taskId + '/complete');

    $('#task-completion-modal .alert-container').empty();
    console.log($('#task-completion-modal form'));
  });

  $('#task-completion-modal form').on('ajax:success', function() {
    Turbolinks.visit('/');
  });

  $('#task-completion-modal form').on('ajax:error', function(event, xhr) {
    var error = xhr.responseJSON.error || "Something went wrong";
    var alertString = '<div class="alert alert-danger alert-dismissible" role="alert">' +
      '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
      error +
    '</div>';
    $('#task-completion-modal .alert-container').append(alertString);
  });
});
