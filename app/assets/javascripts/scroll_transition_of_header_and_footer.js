// $(function() {
//   var $win = $(window),
//       $header = $('header'),
//       $footer = $('footer'),
//       headerHeight = $header.outerHeight(),
//       footerHeight = $footer.outerHeight(),
//       startPos = 0;

//   $win.on('load scroll', function() {
//     var value = $(this).scrollTop();
//     if ( value > startPos && value > headerHeight ) {
//       $header.css('top', '-' + headerHeight + 'px');
//       $footer.css('bottom', '-' + footerHeight + 'px');
//     } else {
//       $header.css('top', '0');
//       $footer.css('bottom', '0');
//     }
//     startPos = value;
//   });
// });
// 無理につけなくていいかも