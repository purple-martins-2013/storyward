$(document).ready(function() {
  var introguide = introJs();
  var startButton = $('#profile-help');

  startButton.on('click', function(){
    introguide.start();
  });

  introguide.setOptions({
      steps: [
          {
            element: '#profile-picture',
            intro: 'Welcome to Storyward! This guide will help you find your way.<br><br>Use the arrow keys for navigation or hit ESC to exit the tour immediately.',
            position: 'bottom'
          },
          {
            element: '.top-bar',
            intro:  'Here\'s a fancy navigation bar! Click \'Browse Stories\' to explore user created stories. Click \'Create Story\' to write your own!',
            position: 'bottom'
          },
          {
            element: '#created-stories',
            intro: 'Here are all the stories you\'ve created. Click the story to view it\'s tree in the \'Story Viewer\'',
            position: 'right'
          },
          {
            element: '.nodes-contributed',
            intro: 'Here are nodes you\'ve added to stories. Click the title to view their tree in the \'Story Viewer\'',
            position: 'right'
          },
          {
            element: '#favorite-authors',
            intro: 'Favorite authors are added when you bookmark a story. Click to view the author\'s profile.',
            position: 'right'
          },
          {
            element: '#favorite-stories',
            intro: "Favorite stories are added when you bookmark a story. Click the title to read the story.",
            position: 'left'
          }
      ]
  });
});