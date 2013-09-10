//= require helpers/spec_helper

describe("LightDimmer", function() {
  describe("clicking on .dimlights", function() {
    it("dims the readingPage", function() {
      var buttons = affix('.buttons')
      buttons.affix('.dimlights');
      buttons.affix('.brighten');
      var readingPage = {
        dim: jasmine.createSpy(),
        brighten: jasmine.createSpy()
      }

      var dimmer = new LightDimmer(buttons, readingPage);

      $('.dimlights').trigger('click');

      expect(readingPage.dim).toHaveBeenCalled();
    });
  });
});

describe("ReadingPage", function() {
  var storyPage, readingPage, brightColor, darkColor;
  
  beforeEach(function() {
    storyPage = affix('#show-story');

    readingPageDom = affix('#reading-page');
    // spyOn(readingPageDom, 'animate');
    readingPage = new ReadingPage(readingPageDom, storyPage);

    darkColor = new Color([4,5,6]);
    brightColor = new Color([1,2,3]);
    spyOn(Color.prototype, 'saturate').andCallFake(function(ratio) {
      return ratio == 2 ? brightColor : darkColor ;
    });
  });

  describe("dim", function() {
    it("adds box-shadowify to the storyPage", function() {
      readingPage.dim();
      expect(storyPage).toHaveClass('box-shadowify');
    });

    it("darkens the background color", function() {
      readingPage.dim();
      expect(readingPageDom.animate).toHaveBeenCalledWith({
        backgroundColor: "rgb(4,5,6)"
      }, 500);
    });
  });

  describe("brighten", function(){
    it("removes box-shadowify to the storyPage", function() {
      readingPage.brighten();
      expect(storyPage).not.toHaveClass('box-shadowify');
    });

    it("brightens the background color", function(){
      readingPage.brighten();
      console.log($('#reading-page').css("background"));
      // expect($('<div style="display: none; margin: 10px;"></div>')).toHaveCss({margin: "10px"});
      expect($('#reading-page')).toHaveCss({background: $('#reading-page').css("background")});
    });
  });
  


});

