// $(document).ready(function() {
//   if (document.getElementById("index-page")) {
//     grabData();
//   }
// });

function grabData() {
  var json
  var initialNodeIds = $("#group-chart").data("nodes");
  console.log(initialNodeIds.children[0].id);

  $.get("/nodes/details/3", function(response) {
      console.log(response);
      json = response;//+index.toString();;
      tree = new Tree(json);
      tree.update();
  });
}

function color(d) {
  //return '#77270e'
  return d._children ? "#81390e" : d.children ? "#81390e" : '#222222';
};

function linkColor(d) {
  return '#fcb483'
  //return d._children ? "#fcb483" : d.children ? "#14db24" : '#'+Math.floor(Math.random()*16777215).toString(16);
};



function Tree(root) {


  this.root = root;
  this.w = window.innerWidth/ 2;
  this.h = window.innerHeight / 1.5;
  this.r = 15;
  this.node
  this.link

  this.force = d3.layout.force()
                .on("tick", this.tick)
                .size([this.w, this.h]);

  this.vis = d3.select("#group-chart").append("svg:svg")
    .attr("width", this.w)
    .attr("height", this.h);
}; 



Tree.prototype.update = function() {
  var nodes = this.flatten();
  var links = d3.layout.tree().links(nodes);

  // Restart the force layout.
  console.log("before force")
  this.force
      .nodes(nodes)
      .links(links)
      .start();

  // Update the links…
  this.link = this.vis.selectAll("line.link")
      .data(links, function(d) { return d.target.id; })
      .style("stroke-width", "1.5px")
      .style("stroke", linkColor);
  
  // Enter any new links.
  this.link.enter().insert("svg:line", ".node")
      .attr("class", "link")
      .attr("x1", function(d) { return d.source.x; })
      .attr("y1", function(d) { return d.source.y; })
      .attr("x2", function(d) { return d.target.x; })
      .attr("y2", function(d) { return d.target.y; });

  // Exit any old links.
  this.link.exit().remove();

  // Update the nodes…
  this.node = this.vis.selectAll("circle.node")
      .data(nodes, function(d) { return d.id; })
      .style("fill", color);

  // Enter any new nodes.
  this.node.enter().append("svg:circle")
      .attr("class", "node")
      .attr("cx", function(d) { return d.x; })
      .attr("cy", function(d) { return d.y; })
      .attr("r", function(d) { return Math.sqrt(d.size) / 10 || 4.5; })
      .style("fill", color)
      .on("click", this.click)
      .call(this.force.drag);

  // Exit any old nodes.
  this.node.exit().remove();
};

Tree.prototype.toggleChildren = function(d) {
  if (d.children) {
    d._children = d.children;
    d.children = null;
  } else {
    d.children = d._children;
    d._children = null;
  }
  this.update();
}

Tree.prototype.click = function(d) {
  this.toggleChildren(d);
}

Tree.prototype.flatten = function() {
  var nodes = [], i = 0;

  function recurse(node) {
    if (node.children) node.children.forEach(recurse);
    if (!node.id) node.id = ++i;
    nodes.push(node);
  }
  console.log('flatten');
  console.log(this.root);

  recurse(this.root);
  return nodes;
};

Tree.prototype.tick = function() {
  console.log("in tick")
  this.link.attr("x1", function(d) { return d.source.x; })
      .attr("y1", function(d) { return d.source.y; })
      .attr("x2", function(d) { return d.target.x; })
      .attr("y2", function(d) { return d.target.y; });

  node.attr("cx", function(d) { return d.x; })
      .attr("cy", function(d) { return d.y; });
};


