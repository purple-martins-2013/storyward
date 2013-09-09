jasmine.getFixtures().fixturesPath = '/spec/javascripts/fixtures'
describe("Experimentation", function() {
  
  // var elem;

  // beforeEach(function() {
  //   elem = $('<div id="container"><p>Hello World</p></div>');
  //   // loadFixtures('nodesfixture.html');
  // });

  // it("can load fixtures from a file", function(){
  //   expect( $('#reading-page') ).toExist();
  // });
  it("should add class box-shadowify", function() {
    console.log("hello")
    console.log(loadFixtures('nodesfixture.html'))
    console.log(setFixtures("<div id='reading-page'><div id='reading-background'><button class='dimlights'>Dim Lights</button><button class='brighten'>Brighten</button><div id ='show-story'></div></div></div>"))
    console.log("bye")
    // loadFixtures('nodesfixture.html');


    toggleLights($('.dimlights'));
  });
});

