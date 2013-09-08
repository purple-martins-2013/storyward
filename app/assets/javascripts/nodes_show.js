function toggleLights(selector) {
  var bg = selector.parent();
  var bgColor = bg.css("background-color").match(/\d{1,3}/g);

  if (selector.hasClass('dimlights')) {
    var r = Math.floor(Math.pow(bgColor[0], 1/2));
    var g = Math.floor(Math.pow(bgColor[1], 1/2));
    var b = Math.floor(Math.pow(bgColor[2], 1/2));
    $('#show-story').addClass('box-shadowify');
  } 
  else {
    var r = Math.floor(Math.pow(bgColor[0], 2));
    var g = Math.floor(Math.pow(bgColor[1], 2));
    var b = Math.floor(Math.pow(bgColor[2], 2));
    $('#show-story').removeClass('box-shadowify');
  }

  var newBgColor = "rgb("+r+","+g+","+b+")";
  console.log(newBgColor);
  bg.animate({backgroundColor: newBgColor}, 500);
  selector.toggle();
  selector.siblings('button').toggle();
}

$(document).ready(function(){
  $('.dimlights').on('click', function() {
    toggleLights($(this));
  });

  $('.brighten').on('click', function() {
    toggleLights($(this));
  });
});


      // 'slow', function() {
      // console.log($(this));
      // $(this).css('background-color', 'black');
