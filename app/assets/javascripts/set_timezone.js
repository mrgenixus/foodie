$.post('/session/', {
  _method: 'PUT',
  session: {
    time_zone: jstz.determine().name()
  }
});