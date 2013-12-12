(function(){
  function checked(v){
    return $(v).is(':checked');
  }

  function setupRowSelect(){
    $(document).off('click.row-select').on('click.row-select', '.row-select[data-row]',function(e){
      var row = $(e.currentTarget).data('row');
      var checkboxes = $('.row-' + row).find('input[type=checkbox]');
      
      checkboxes.prop('checked',! _.all(checkboxes,checked));
      
    });
  }
  $(setupRowSelect);
  $(document).on('page:load',setupRowSelect);
})();