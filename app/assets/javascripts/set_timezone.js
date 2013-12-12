var tz = jstz.determine().name();
console.log('setting time zone');
$.post('/session', {
  _method: 'PUT',
  session: {
    time_zone: tz
  }
});