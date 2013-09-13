$(document).ready(function(){

  $('stories-contributed').on('click', 'a', function(e){
    e.preventDefault();
    console.log($(this).data("node"));
  })

});
