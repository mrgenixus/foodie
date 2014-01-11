
  function showNewVenue(e){
    $select = $(e.currentTarget).closest('.row').find('select.venue_select');

    $modal.find('form').one('ajax:success', function(event, data){
      var venue = data.venue;
      $select.prepend($('<option>').val(venue.id).text(venue.name)).val(venue.id);
      $('select.venue_select').not($select).append($('<option>').val(venue.id).text(venue.name));

      $modal.find('form').each(function(i,form){
        $.each(form.elements,function(i,el){
          $(el).val('');
        });
      });
      $modal.modal('hide');
    });
    console.log('showing', $modal);
    $modal.modal();
    return;
  }

  $modal = $('#new_venue_modal');

  $modal.on('click', '.btn-default', function(){
    $modal.find('form').submit();
  });


  $(function(){
    $(document).on('click', '.add_new_venue', showNewVenue);
  });

  console.log('initted');