function classnames() {
  return Array.prototype.map.call(arguments, function(arg) {
    if (typeof arg === 'string') {
      return arg;
    } else if (Array.isArray(arg)) {
      return arg.join(' ');
    } else {
      return Object.keys(arg).filter(function(k) { return arg[k] }).join(' ');
    }
  }).join(' ');
}
