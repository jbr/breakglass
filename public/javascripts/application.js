$(function(){
  $('.meeting-place').live('click', function(){
    if($(this).find('.static').is(':visible')) {
      $(this).find('.static, .meeting-place-form').toggle('blind')
    }
  })
})

$(function(){
  $('.emg-contact').live('click', function(){
    if($(this).find('.static').is(':visible')) {
      $(this).find('.static, .emg-contact-form').toggle('blind')
    }
  })
})
