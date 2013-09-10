function LightDimmer(buttons, readingPage, story) {
  this.readingPage = readingPage;
  var self = this;
  buttons.on('click', '.dimlights', function() {
    readingPage.dim();
    self.toggleButton($(this));
  });

  buttons.on('click', '.brighten', function() {
    readingPage.brighten();
    self.toggleButton($(this));
  });
}


LightDimmer.prototype.toggleButton = function(button) {
  button.toggle();
  button.siblings('button').toggle();
};

function ReadingPage(page, story) {
  this.page = page;
  this.story = story;
}

ReadingPage.prototype.dim = function() {
  this.story.addClass('box-shadowify');
  this.__updateColor(this.__color().saturate(1/2));
};

ReadingPage.prototype.brighten = function(color) {
  this.story.removeClass('box-shadowify');
  this.__updateColor(this.__color().saturate(2));
};

ReadingPage.prototype.__updateColor = function(color) {
  this.page.animate({
    backgroundColor: color.toRGB()
  }, 500);
};

ReadingPage.prototype.__color = function() {
  var cssColor = this.page.css("background-color").match(/\d{1,3}/g);
  return new Color(cssColor);
};


function Color(rgbArray) {
  this.rgbArray = rgbArray;
}

Color.prototype.saturate = function(ratio) {
  var r = Math.floor(Math.pow(this.rgbArray[0], ratio));
  var g = Math.floor(Math.pow(this.rgbArray[1], ratio));
  var b = Math.floor(Math.pow(this.rgbArray[2], ratio));
  return new Color([r,g,b]);
};

Color.prototype.toRGB = function() {
  return "rgb("+this.rgbArray[0]+","+this.rgbArray[1]+","+this.rgbArray[2]+")";
};
