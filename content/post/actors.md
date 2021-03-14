---
date: "2014-05-03"
title: Actor Maps
tags: ["d3"]
author: Me
showToc: false
TocOpen: false
draft: false
hidemeta: false
comments: false
disableHLJS: true # to disable highlightjs
disableShare: false
disableHLJS: false
searchHidden: true
---
A little while ago I wrote some terrible code which took data from <a href="http://themoviedb.org/">themoviedb.org</a> and pulled all the actors you listed found every film they&#8217;d been involved in.  The original idea was to produce maps a little like the fabulous Tube map (which I&#8217;ve always had a bit of a love for).  It turned out that making the things that look like the tube map is hard, but the data was interesting.  Specifically what was interesting was were actors turned out to have been in numerous films together.

Originally I used GraphViz to produce some slightly clunky maps, but it turned out <a href="https://github.com/mbostock/d3/wiki/Force-Layout">D3 Force Graphs</a> were easy enough to implement and pretty.  I&#8217;ve <a href="https://github.com/coldclimate/actordata">published the Python</a> script I used to pull data across.

This still renders badly (I&#8217;m not CSS master) but this great wobbily bugger represents the main cast members of <a href="http://www.imdb.com/title/tt0137523/">Fightclub</a>.  <a href="view-source:http://www.theapproachablegeek.co.uk/blog/actormaps/">View the source</a> of this page for the JS.

<div id="hook"></div>

<style>

.link {
  fill: none;
  stroke: #666;
  stroke-width: 1.5px;
}



.link.resolved {
  stroke-dasharray: 0,2 1;
}

circle {
  fill: #ccc;
  stroke: #333;
  stroke-width: 1.5px;
}

text {
  font: 10px sans-serif;
  pointer-events: none;
  text-shadow: 0 1px 0 #fff, 1px 0 0 #fff, 0 -1px 0 #fff, -1px 0 0 #fff;
}

</style>

<script src="http://d3js.org/d3.v3.min.js"></script>

<script>

var arrData =
[{'films': ['American History X', 'Fight Club', 'Frida', '25th Hour', 'The Illusionist', 'Kingdom of Heaven', 'Primal Fear', 'The People vs. Larry Flynt', 'The Incredible Hulk', 'Rounders', 'Keeping the Faith', 'The Score', 'The Painted Veil', 'Stone', 'Moonrise Kingdom', 'The Bourne Legacy', 'The Apple Pushers', 'The Grand Budapest Hotel', 'Out of the Past', 'Salinger', 'Birdman', 'Sausage Party', 'The Invention of Lying', 'Down in the Valley', 'Death to Smoochy', 'Red Dragon', 'The Italian Job', 'Everyone Says I Love You', 'Leaves of Grass', 'Pride and Glory'], 'colour': 'yellowgreen', 'type': 'edward-norton', 'name': 'Edward Norton'}, {'films': ['Twelve Monkeys', 'Snatch', "Ocean's Eleven", "Ocean's Twelve", 'A River Runs Through It', 'Meet Joe Black', "Ocean's Thirteen", 'True Romance', 'Being John Malkovich', 'Fight Club', 'Interview with the Vampire', 'Troy', 'Mr. & Mrs. Smith', 'Se7en', 'Sleepers', 'Seven Years in Tibet', 'Babel', 'Spy Game', 'Thelma & Louise', 'Legends of the Fall', "The Devil's Own", 'The Assassination of Jesse James by the Coward Robert Ford', 'Kalifornia', 'Too Young to Die?', 'Confessions of a Dangerous Mind', 'The Curious Case of Benjamin Button', 'Burn After Reading', 'The Hamster Factor and Other Tales of Twelve Monkeys', 'Cutting Class', 'Cool World', 'Sinbad: Legend of the Seven Seas', 'Moneyball', 'Megamind', 'His Way', 'Johnny Suede', 'Killing Them Softly', 'Inglourious Basterds', 'Happy Feet Two', 'Contact', 'Across the Tracks', 'Ultimate Fights from the Movies', 'The Favor', 'World War Z', 'Happy Together', 'The Image', '12 Years a Slave', 'Voyage of Time', 'The Counselor', '8', 'The Tiger', 'Fury', 'The Mexican', 'Dirty Tricks', 'The Tree of Life', 'The Dark Side of the Sun'], 'colour': 'yellow', 'type': 'brad-pitt', 'name': 'Brad Pitt'}, {'films': ['Charlie and the Chocolate Factory', 'Wallace & Gromit: The Curse of the Were-Rabbit', 'Terminator Salvation', 'Fight Club', 'Big Fish', 'Harry Potter and the Order of the Phoenix', 'Harry Potter and the Half-Blood Prince', 'Planet of the Apes', "The Revengers' Comedies", 'Hamlet', 'Frankenstein', 'Corpse Bride', 'Novocaine', 'A Room with a View', 'Lady Jane', 'The Gruffalo', 'Live from Baghdad', 'Sweeney Todd: The Demon Barber of Fleet Street', 'Till Human Voices Wake Us', 'Enid', 'Conversations with Other Women', 'Dark Shadows', 'Twelfth Night', "The King's Speech", "The King's Speech", 'The Wings of the Dove', 'Suffragette', 'Salting The Battlefield', 'Turks & Caicos', 'Fatal Deception: Mrs. Lee Harvey Oswald', 'A Hazard of Hearts', "The Gruffalo's Child", 'Toast', "Margaret's Museum", 'Les Mis\xe9rables', 'A Merry War', 'Francesco', 'The Lone Ranger', 'The Theory of Flight', 'Arms and the Man', 'Where Angels Fear to Tread', 'Getting It Right', 'Great Expectations', 'Cinderella', 'Women Talking Dirty', 'A Therapy', 'The Mask', 'The Young and Prodigious T.S. Spivet', 'The Price of Kings: Shimon Peres', 'Carnivale', 'Burton and Taylor', 'Mighty Aphrodite', 'Sixty Six', 'Merlin', 'Howards End', 'The Heart of Me', 'Alice in Wonderland', 'Harry Potter and the Deathly Hallows: Part 1', 'Harry Potter and the Deathly Hallows: Part 2'], 'colour': 'wheat', 'type': 'helena-bonham-carter', 'name': 'Helena Bonham Carter'}]




var links = [];
var arrCharacters=[];

arrData.forEach(function(set){
  var intLength = set.films.length;
  arrCharacters.push(set.name);
  for (var i = 0; i < intLength-1; i++) {
   objLink = {
    source : set.films[i],
    target : set.films[i+1],
    type : set.type,
    colour : set.colour
   };
   links.push(objLink);
}

});

var nodes = {};

// Compute the distinct nodes from the links.
links.forEach(function(link) {
  link.source = nodes[link.source] || (nodes[link.source] = {name: link.source});
  link.target = nodes[link.target] || (nodes[link.target] = {name: link.target});
});

var width = window.innerWidth,
    height = window.innerHeight;

var force = d3.layout.force()
    .nodes(d3.values(nodes))
    .links(links)
    .size([width, height])
    .linkDistance(60)
    .charge(-0.0001*(window.innerHeight*window.innerWidth))
    .on("tick", tick)
    .start();

var svg = d3.select("#hook").append("svg")
    .attr("width", width)
    .attr("height", height);

console.log(svg);

// Per-type markers, as they don't inherit styles.
svg.append("defs").selectAll("marker")
    .data(arrCharacters)
  .enter().append("marker")
    .attr("id", function(d) { return d; })
    .attr("viewBox", "0 -5 10 10")
    .attr("refX", 15)
    .attr("refY", -1.5)
    .attr("markerWidth", 6)
    .attr("markerHeight", 6)
    .attr("orient", "auto")
  .append("path")
    .attr("d", "M0,-5L10,0L0,5");

var path = svg.append("g").selectAll("path")
    .data(force.links())
    .enter().append("path")
    .attr("style", function(d) { console.log(d);return "fill: " + d.colour +";"; })
    .attr("marker-end", function(d) { return "url(#" + d.type + ")"; });

var circle = svg.append("g").selectAll("circle")
    .data(force.nodes())
  .enter().append("circle")
    .attr("r", 6)
    .call(force.drag);

var text = svg.append("g").selectAll("text")
    .data(force.nodes())
  .enter().append("text")
    .attr("x", 8)
    .attr("y", ".31em")
    .text(function(d) { return d.name; });

// Use elliptical arc path segments to doubly-encode directionality.
function tick() {
  path.attr("d", linkArc);
  circle.attr("transform", transform);
  text.attr("transform", transform);
}

function linkArc(d) {
  var dx = d.target.x - d.source.x,
      dy = d.target.y - d.source.y,
      dr = Math.sqrt(dx * dx + dy * dy);
  return "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y;
}

function transform(d) {
  return "translate(" + d.x + "," + d.y + ")";
}

var legend = svg.append("g")
    .attr("class", "legend")
    .attr("x", window.innerWidth - 65)
    .attr("y", 25)
    .attr("height", 100)
    .attr("width", 100);

  legend.selectAll('g').data(arrData)
      .enter()
      .append('g')
      .each(function(d, i) {
        var g = d3.select(this);
        g.append("rect")
          .attr("x", 10)
          .attr("y", i*25)
          .attr("width", 10)
          .attr("height", 10)
          .style("fill", arrData[i].colour);
        
        g.append("text")
          .attr("x", 30)
          .attr("y", i * 25 + 8)
          .attr("height",30)
          .attr("width",100)
          .style("fill", arrData[i].colour)
          .text(arrData[i].name);

      });
</script>

