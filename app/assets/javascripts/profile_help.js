var prepWalkthrough = function() {
  var introguide = introJs();
  var startButton = $('#profile-help');

    introguide.setOptions({
      steps: [
          {
            element: '#profile-picture',
            intro: 'Welcome to Storyward! This guide will help you find your way.<br><br>Use the arrow keys for navigation or hit ESC to exit the tour immediately.',
            position: 'bottom'
          },
          {
            element: '.top-bar',
            intro:  "Here's a fancy navigation bar! Click 'Browse Stories' to explore user created stories. Click 'Create Story' to write your own!",
            position: 'bottom'
          },
          {
            element: '#created-stories',
            intro: "Here are all the stories you've created. Click the story to view it's tree in the 'Story Viewer'",
            position: 'right'
          },
          {
            element: '.nodes-contributed',
            intro: "Here are nodes you've added to stories. Click the title to view their tree in the 'Story Viewer'",
            position: 'right'
          },
          {
            element: '#favorite-authors',
            intro: "Favorite authors are added when you bookmark a story. Click to view the author's profile.",
            position: 'right'
          },
          {
            element: '#favorite-stories',
            intro: "Favorite stories are added when you bookmark a story. Click the title to read the story.",
            position: 'left'
          },
          {
            element: '#story-viewer',
            intro: "Here is the story viewer. When you click on a created story or node, a little ball will pop up in the center of the screen. Double click the ball to expand the tree. Hover over any node to see a preview of that particular branch's story. Click 'Check out this story!' to view the story in the cozy reading page.<br><br>There is even more the tree can do, explore!",
            position: 'top'
          }
      ]
  });
  introguide.oncomplete(function(){
    prepWalkthrough();
  });

  introguide.onexit(function(){
    prepWalkthrough();
  });

  listenForHelp(introguide);
};

var listenForHelp = function(intro) {
  $('#profile-help').on('click', function(){
    intro.start();
    $(this).hide();
  });
};

$(document).ready(function() {
  prepWalkthrough();
});