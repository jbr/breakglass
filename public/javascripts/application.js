$(function(){
  $('.meeting-place').click(function(){
    if($(this).find('.static').is(':visible')) {
      $(this).find('.static, .meeting-place-form').toggle('blind')
    }
  })
})