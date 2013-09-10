//= require helpers/spec_helper

describe("ReadingPage", function() {
  var storyPage, readingPage, brightColor, darkColor;
  
  beforeEach(function() {
    storyPage = affix('#show-story');

    readingPageDom = affix('#reading-page');
    spyOn(readingPageDom, 'animate');
    readingPage = new ReadingPage(readingPageDom, storyPage);

    darkColor = new Color([4,5,6]);
    brightColor = new Color([1,2,3]);
    spyOn(Color.prototype, 'saturate').andCallFake(function(ratio) {
      return ratio == 2 ? brightColor : darkColor ;
    });
  });

  describe("dimColor", function() {
    it("adds box-shadowify to the storyPage", function() {
      readingPage.dimColor();
      expect(storyPage).toHaveClass('box-shadowify');
    });

    it("returns dark background color", function() {
      expect(readingPage.dimColor()).toEqual("rgb(4,5,6)");
    });
  });

  describe("brightColor", function(){
    it("removes box-shadowify to the storyPage", function() {
      readingPage.brightColor();
      expect(storyPage).not.toHaveClass('box-shadowify');
    });

    it("returns bright background color", function(){
      expect(readingPage.brightColor()).toEqual("rgb(1,2,3)");
    });
  });
  


});

