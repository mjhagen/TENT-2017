$(function() {
  $('#fw1_trace')
    .on('click', function() {
      $('#fw1_trace table').toggle();
    });

  $('.level-2 li')
    .on('click', function() {
      location.href = $(this).find('a').attr('href');
    });

  $(".level-2 li a")
    .on('click', function(e) {
      e.stopPropagation();
    });
});