function checked(v){
  return $(v).is(':checked');
}
$(function(){
  $('.row-select[data-row]').on('click', function(e){
    console.log('clicked');
    var row = $(e.currentTarget).data('row');
    var checkboxes = $('.row-' + row).find('input[type=checkbox]');
    
    checkboxes.prop('checked',! _.all(checkboxes,checked));
    
  });
});