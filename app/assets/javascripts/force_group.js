$(document).ready(function() {
  if (document.getElementById("index-page")) {
    new forceGroup("#index-page");
  }
});

function forceGroup(container) {

  var width = 600,
      height = 600,
      root;

  var curElement, lastElement, timeoutId, lastColor, lastWidth, lastStroke;

  $("#group-chart").on("mouseenter", "circle.node", function() {
    curElement = this;
    timeoutId = setTimeout(function() {
      if (lastElement) {
        $(lastElement).css("fill", lastColor).css("stroke-width", lastWidth).css("stroke", lastStroke);
      }
      populateTitle(curElement);
      lastElement = curElement;
      lastColor = curElement.style.fill;
      lastWidth = curElement.style.strokeWidth;
      lastStroke = curElement.style.stroke;
      $("circle.node").css("opacity", "0.8");
      $(curElement).css("fill", "orange").css("opacity", "1.0").css("stroke", "red").css("stroke-width", "6px");
    }, 600);
  });

  $("#group-chart").on("mouseleave", "circle.node", function() {
    if (timeoutId) {
      clearTimeout(timeoutId);
    }
  });

  var fill = d3.scale.category10();

  var json = $("#group-chart").data("nodes");

  takeJson();

  function takeJson() {
    root = json;
    update();
  }

  function populateTitle(curElement) {
    var book_id = curElement.__data__["book_id"];
    $.get("nodes/query/"+book_id,
      function(response) {
        $("#superNavTwo").replaceWith("<div id='superNavTwo' class='small-3-columns' style='margin: -450px 10% 0 0'><h2><a href='nodes/" + book_id + "'>"+response['title']+"</a></h2><h4>"+response['content']+"</h4></div>");
        $('#superNavTwo').slideDown();
      });
  }

  function update() {

    var nodes = flatten(root);

    var force = d3.layout.force()
        .nodes(nodes)
        .size([width, height])
        .on("tick", tick)
        .start();

    var svg = d3.select("#group-chart").append("svg")
        .attr("width", width)
        .attr("height", height)
        .call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", redraw))
        .attr("pointer-events", "all")
        .attr("viewBox", "0 0 "+width+" "+height)
        .attr("preserveAspectRatio","xMinYMid");

    var node = svg.selectAll(".node")
        .data(nodes)
      .enter().append("circle")
        .attr("class", "node")
        .attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; })
        .attr("r", 8)
        .style("fill", function(d, i) { return fill(i & 3); })
        .style("stroke", function(d, i) { return d3.rgb(fill(i & 3)).darker(2); })
        .call(force.drag)
        .on("mousedown", function(d, i) { 
          d3.event.stopPropagation();
          $("#chart-holder").replaceWith("<div id='chart-holder' class='small-9-columns reveal-modal' ><div id='chart' class='small-6-columns' data-node='"+d["book_id"]+"'></div><div><a id='node-link' style='display: none'></a></div><div id='superNav'></div><a class='close-reveal-modal'>&#215;</a></div>");
          $("#chart-holder").foundation('reveal', 'open');
          new forceGraph(container);
        });

    svg.style("opacity", 1e-6)
      .transition()
        .duration(1000)
        .style("opacity", 1);

    d3.select("#group-chart")
        .on("mousedown", mousedown);

    function redraw() {
      trans=d3.event.translate;
      scale=d3.event.scale;
      $("#group-chart .node").attr("transform",
          "translate(" + trans + ")"
              + " scale(" + scale + ")");
    }

    function tick(e) {

      // Push different nodes in different directions for clustering.
      var k = 6 * e.alpha;
      nodes.forEach(function(o, i) {
        o.y += i & 1 ? k : -k;
        o.x += i & 2 ? k : -k;
      });

      node.attr("cx", function(d) { return d.x; })
          .attr("cy", function(d) { return d.y; });
    }

    function mousedown() {
      nodes.forEach(function(o, i) {
        o.x += (Math.random() - .5) * 40;
        o.y += (Math.random() - .5) * 40;
      });
      force.resume();
    }

      // Returns a list of all nodes under the root.
    function flatten(root) {
      var nodes = [];
      for (var i = 0; i < root["children"].length; i++) {
        nodes.push({book_id: root["children"][i]["id"]});
      }
      return nodes;
    }
  }
}