$(function(){
  $('[data-method=delete]').on('ajax:success', function(e){
    console.log('caught deletion');
    $(e.currentTarget).parents('.row.item').slideUp(1000);
  });
});