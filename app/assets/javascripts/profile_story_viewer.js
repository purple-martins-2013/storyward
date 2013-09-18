$(document).ready(function(){

  $('.stories-contributed').on('click', 'a', function(e){
    e.preventDefault();
    console.log("enter");

    console.log($(this).data("node"));
    var node = $(this).data("node");

       
    $('#story-viewer #chart').children().remove();
    $('#story-viewer #chart').attr("data-node", node);

    console.log($('#story-viewer #chart').data("node")); 
    new forceGraph("#show-user");
  });

  $('.nodes-contributed').on('click', 'a', function(e){
    e.preventDefault();
    console.log("enter");

    console.log($(this).data("node"));
    var node = $(this).data("node");

       
    $('#story-viewer #chart').children().remove();
    $('#story-viewer #chart').attr("data-node", node);
    console.log($('#story-viewer #chart').data("node")); 
    new forceGraph("#show-user");
  });

});
