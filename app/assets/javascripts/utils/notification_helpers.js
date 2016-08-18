(function(window) {
  var NotificationHelpers = {};

  // "Respectfully" asks for permission.
  // If permission is already granted, no-op.
  // If permission is already denied, no-op.
  // Otherwise, ask the user.
  function requestPermission() {
    if (Notification.permission === 'granted') {
      return Promise.resolve();
    } else if (Notification.permission === 'denied') {
      return Promise.reject();
    } else {
      return new Promise(function(resolve, reject) {
        Notification.requestPermission(function(permission) {
          if (permission === 'granted') {
            resolve();
          } else {
            reject();
          }
        });
      });
    }
  }

  function notify(title, options) {
    return requestPermission().then(function() {
      return new Notification(title, options);
    });
  }

  NotificationHelpers.requestPermission = requestPermission;
  NotificationHelpers.notify = notify;

  if (!"Notification" in window) {
    for (var fn in NotificationHelpers) {
      NotificationHelpers[fn] = function() { };
    }
  }

  window.NotificationHelpers = NotificationHelpers;
})(window);
