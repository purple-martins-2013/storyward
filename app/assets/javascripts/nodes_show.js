function LightDimmer(buttons, readingPage, story) {
  this.readingPage = readingPage;
  this.buttons = buttons;
  var self = this;
  var lightDimmer = this;


  buttons.on('click', '.dimlights', function(){
    lightDimmer.dimPage($(this));
  });

  buttons.on('click', '.brighten', function(){
    lightDimmer.brightenPage($(this));
  });
}

LightDimmer.prototype.dimPage = function(button) {
    this.buttons.unbind('click');
    this.updateColor(this.readingPage.dimColor());
    this.toggleButton(button);
};

LightDimmer.prototype.brightenPage = function(button) {
    this.buttons.unbind('click');
    this.updateColor(this.readingPage.brightColor());
    this.toggleButton(button);
};


LightDimmer.prototype.toggleButton = function(button) {
  button.toggle();
  button.siblings('button').toggle();
};

LightDimmer.prototype.updateColor = function(color) {
  var lightDimmer = this;
  console.log(lightDimmer);

  this.readingPage.page.animate({
    backgroundColor: color.toRGB()
  }, 500, function(){
    lightDimmer.buttons.on('click', '.brighten', function(){
      lightDimmer.brightenPage($(this));
    });
    lightDimmer.buttons.on('click', '.dimlights', function(){
      lightDimmer.dimPage($(this));
    });
  });
};



function ReadingPage(page, story) {
  this.page = page;
  this.story = story;
}

ReadingPage.prototype.dimColor = function() {
  this.story.addClass('box-shadowify');
  return this.__color().saturate(1/2);
};

ReadingPage.prototype.brightColor = function() {
  this.story.removeClass('box-shadowify');
  return this.__color().saturate(2);
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
