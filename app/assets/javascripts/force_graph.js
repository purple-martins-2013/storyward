$(document).ready(function() {
  if (document.getElementById("node-page")) {
    new forceGraph("#node-page")
  }

  if (document.getElementById("reading-background")) {
    $("#reading-background").on("click", "#story-map", function() {
      $("#chart-holder").replaceWith("<div id='chart-holder' class='small-9 columns reveal-modal' ><div id='chart' class='small-6 columns' data-node='"+$("#story-map").data("id")+"'></div><div><a id='node-link' style='display: none'></a></div><div id='superNav'></div><a class='close-reveal-modal'>&#215;</a></div>");
      $("#chart-holder").foundation('reveal', 'open');
      new forceGraph("#reading-background");
    });
  }
});


function forceGraph(container) {
  window.oncontextmenu = function () {
    if (clickedOnNode) {
      return false;
    }
  }

  $(container).on("mouseenter", ".node-preview", function(e) {
    e.preventDefault();
    $(this).find(".preview").hide(200);
    $(this).find(".full").show(200);
    $(this).addClass("full-color", 400);
  });

  var previewEle;

  $(container).on("mouseleave", ".node-preview", function(e) {
    e.preventDefault();
    $(this).find(".preview").show(200);
    $(this).find(".full").hide(200);
    previewEle = this;
    setTimeout(function() {
      $(previewEle).removeClass("full-color", 400);
    }, 400);
  });  


  var curElement, timeoutId, clickedOnNode = false, zoomFactor = 4;

  $("#chart").on("mousedown", function() {
    clickedOnNode = true;
  });

  $("#chart").on("mouseleave", function() {
    clickedOnNode = false;
  })

  $("#chart").on("mouseenter", "circle.node", function() {
    curElement = this;
    timeoutId = setTimeout(function() {
      update();
      populateNode(curElement);
    }, 600);
  });

  $("#chart").on("mouseleave", "circle.node", function() {
    if (timeoutId) {
      clearTimeout(timeoutId);
    }
  });

  var w = window.innerWidth / 2.5,
      h = window.innerHeight / 1.5,
      r = 15,
      node,
      link,
      root,
      json;

  var force = d3.layout.force()
      .on("tick", tick)
      .size([w, h])
      .linkDistance([20]);

  var vis = d3.select("#chart").append("svg:svg")
      .attr("width", w)
      .attr("height", h)
      .call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", redraw)).on("dblclick.zoom", null)
      .attr("pointer-events", "all")
      .attr("viewBox", "0 0 "+w+" "+h)
      .attr("preserveAspectRatio","xMinYMid");

  createJson();

  function createJson() {
    $.get("/nodes/details/"+$("#chart").data("node"),
      function(response) {
        json = response;
        takeJson();
      });
  }

  function takeJson() {
    root = json;
    
    if (container == "#reading-background" || container == "#show-user") {
      update();
    } else {
      initialize();
    }

    if ($("#story-map").data("id")) {
      populateNode(vis.selectAll("circle.node").filter(function(d, i) {return d["id"] == $("#story-map").data("me")})[0][0] );
    } else if ($("#story-viewer").data("id")) {
      populateNode(vis.selectAll("circle.node").filter(function(d, i) {return d["id"] == $("#story-viewer").data("id")})[0][0] );
    }
  }

  function populateNode(curElement) {
    var data = curElement.__data__["id"];
    
    $.get("/nodes/chain/"+data,//getting ancestry chain for curElement
      function(chain) {
        var story_preview = "<div id='story-preview' style='height: "+ window.innerHeight / 1.7 + "px'>";
        chain.forEach(function(element, index, array) {
         story_preview += ("<div class='node-preview'><h5>" + array[index].title.slice(0, 20) + "</h5><p class='preview small-preview' >" + array[index].content.slice(0, 15) + "...</p><p class='full hide small-preview'>" + array[index].content.slice(0, 400) + "...</p></div>");
          vis.selectAll("circle.node").filter(function(d, i) {return d["id"] == array[index].id})
            .style("fill", "silver")//these are the selected nodes 
            .style("stroke", "#fcb483")
            .style("stroke-width", "4px");
          if (index < array.length - 1) {
            vis.selectAll("line.link").filter(function(d, i) {return d.source["id"] == array[index].id && d.target["id"] == array[index + 1].id})
            .style("stroke-width", "5px")
            .style("stroke", "blue");
          }
       });
        story_preview += "</div>";
        
        if ($("#superNav").html() == "") {
          $("#superNav").replaceWith("<div id='superNav' class='hide'>"+ story_preview + "</div>");
          $("#node-link").replaceWith("<a id='node-link' class='button right' href='/stories/"+data+"'>Check out this story!</a>");
          $("#chart-holder").css("width", "900px");
          $('#superNav').show("slow");
        } else {
          $("#superNav").replaceWith("<div id='superNav'>"+ story_preview + "</div>");
          $("#node-link").replaceWith("<a id='node-link' class='button right' href='/stories/"+data+"'>Check out this story!</a>");
        }
        $("circle.node").css("opacity", "0.8");
        $(curElement).css("fill", "orange").css("opacity", "1.0").css("stroke", "red").css("stroke-width", "6px");

      });
  }

  function redraw() {
    trans=d3.event.translate;
    scale=d3.event.scale;
    $("#chart .node").attr("transform",
        "translate(" + trans + ")"
            + " scale(" + scale + ")");
    $("#chart .link").attr("transform",
        "translate(" + trans + ")"
            + " scale(" + scale + ")");
  }


  function setup() {

  }


  function initialize() {
        var nodes = flatten(root),
        links = d3.layout.tree().links(nodes);
    
    
    // Restart the force layout.

    force
        .nodes(nodes)
        .links(links)
        .start();

    // Update the links…
    link = vis.selectAll("line.link")
        .data(links, function(d) { return d.target.id; })
        .style("stroke-width", "1.5px")
        .style("stroke", linkColor);

    // Enter any new links.
    link.enter().insert("svg:line", ".node")
        .attr("class", "link")
        .attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    // Exit any old links.
    link.exit().remove();

    
        // Update the nodes…
    node = vis.selectAll("circle.node")
        .data(nodes, function(d) {return d.id; })
        .style("fill", color)
        .style("stroke", "#3182bd")
        .style("stroke-width", "1.5px");

    var initialNode = node.enter()[0][node.enter()[0].length-1]; 

    toggleChildren(initialNode.__data__);

  }
 

  function update() {
    var nodes = flatten(root),
        links = d3.layout.tree().links(nodes);
    
    
    // Restart the force layout.

    force
        .nodes(nodes)
        .links(links)
        .start();

    // Update the links…
    link = vis.selectAll("line.link")
        .data(links, function(d) { return d.target.id; })
        .style("stroke-width", "1.5px")
        .style("stroke", linkColor);

    // Enter any new links.
    link.enter().insert("svg:line", ".node")
        .attr("class", "link")
        .attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    // Exit any old links.
    link.exit().remove();

    var node_drag = d3.behavior.drag()
        .on("dragstart", dragstart)
        .on("drag", dragmove)
        .on("dragend", dragend);

    function dragstart(d, i) {
        d3.event.sourceEvent.stopPropagation();
        force.stop() // stops the force auto positioning before you start dragging
    }

    function dragmove(d, i) {
        d3.event.sourceEvent.stopPropagation();
        d.px += d3.event.dx;
        d.py += d3.event.dy;
        d.x += d3.event.dx;
        d.y += d3.event.dy; 
        tick(); // this is the key to make it work together with updating both px,py,x,y on d !
    }

    function dragend(d, i) {
        d3.event.sourceEvent.stopPropagation();
        d.fixed = true; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
        tick();
        force.resume();
    }

    // Update the nodes…
    node = vis.selectAll("circle.node")
        .data(nodes, function(d) {return d.id; })
        .style("fill", color)
        .style("stroke", "#3182bd")
        .style("stroke-width", "1.5px");

    var initialNode = node.enter()[0][node.enter()[0].length-1]; 
    //toggleChildren(initialNode.__data__);
    // Enter any new nodes.
    node.enter().append("svg:circle")
        .attr("class", "node")
        .attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; })
        .attr("r", function(d) { return d.size * 1.5 || 6; })
         // || Math.sqrt(d.children.length) * 4 -- at some point; children does become null though, when expanding closed children
        .style("fill", color)
        .on("dblclick", dblclick)
        .call(node_drag);

    // Exit any old nodes.
    node.exit().remove();
  }

  function tick() {
    node.attr("cx", function(d) { r = this.r.baseVal.value; return d.x = Math.max(r, Math.min(w - r, d.x)); })
        .attr("cy", function(d) { r = this.r.baseVal.value; return d.y = Math.max(r, Math.min(h - r, d.y)); });

    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });
  }

  function color(d) {
    //return '#77270e'
    return d._children ? "#81390e" : d.children ? "#81390e" : '#222222';
  }

  function linkColor(d) {
    return '#fcb483'
    //return d._children ? "#fcb483" : d.children ? "#14db24" : '#'+Math.floor(Math.random()*16777215).toString(16);
  }

  //show title on hover
  function mouseover(d) {
    return d.id;
  }

  function toggleChildren(d) {
    if (d.children) {
      d._children = d.children;
      d.children = null;
    } else {
      d.children = d._children;
      d._children = null;
    }
    update();
  }

  // Toggle children on click.
  function dblclick(d) {
    toggleChildren(d);
  }

  // Returns a list of all nodes under the root.
  function flatten(root) {
    var nodes = [], i = 0;

    function recurse(node) {
      if (node.children) node.children.forEach(recurse);
      if (!node.id) node.id = ++i;
      nodes.push(node);///last node in the array is always initial node
    }
    
    recurse(root);

    return nodes;
  }
}
