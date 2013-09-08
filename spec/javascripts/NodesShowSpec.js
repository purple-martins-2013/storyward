
describe("Experimentation", function() {
  
  var elem;

  beforeEach(function() {
    elem = $('<div id="container"><p>Hello World</p></div>');
  });

  it("can load fixtures from a file", function(){
    loadFixtures('nodesfixture.html');
    expect( $('#reading-page') ).toExist();
  });
});
