---
kind: article
created_at: "2014-05-25"
title: A quick and dirty experiment with Rickshaw
---
<link type="text/css" rel="stylesheet" href="/_assets/rickshaw/graph.css">
<link type="text/css" rel="stylesheet" href="/_assets/rickshaw/detail.css">
<link type="text/css" rel="stylesheet" href="/_assets/rickshaw/legend.css">
<link type="text/css" rel="stylesheet" href="/_assets/rickshaw/lines.css">
<script src="/_assets/rickshaw/d3.min.js"></script>
<script src="/_assets/rickshaw/rickshaw.min.js"></script>

I had some time to kill on the train to Devs Love Bacon, and limited internet access, so I was looking for an offline project to play with and learn something new in a couple of hours.  Step in [Rickshaw](http://code.shutterstock.com/rickshaw/) a graphing library built on [D3](http://d3js.org/) it's a quick way to make beutiful interactive graphs.

I used the data from [the history of the Glastonbury Festival](http://www.glastonburyfestivals.co.uk/history/) to built a graph showing the price and attendance over time.  Simple enough, but with the need to include two different scales (attendance is huge compared to the price) enough of a challenge for a few hours.

The result is down at the bottom, and you can see everything in the source here.

A couple of notes on things I stumbled upon along the way.  I started by pinching an example that looked about right.

* Trying to chance too much at once.  Make the smallest change possible, reload, make sur eyou've not nuked the whole thing.  I found the error messages to be mildly useful.
* The data series are really simple lists of objects with an x and a y value for each point.
* The data series need to be sorted before you graph them.  My data was a mess (long story) so using a quick and dirt compare method made sense.
* You can apply different scales to each data series.  I experimented with log scales but couldn't get it working quickly so ended up with different linear scales.
* There's a bug in my hovercard which shows the date at 1970.  I'll get back to this.




<div id="chart_container">
	<div id="chart"></div>
	<div id="legend_container">
		<div id="smoother" title="Smoothing"></div>
		<div id="legend"></div>
	</div>
	<div id="slider"></div>
</div>

<script>

var seriesData = [];

seriesData[0] = [{
	x: 2011,
	y: 177500
}, {
	x: 2010,
	y: 177500
}, {
	x: 2008,
	y: 177500
}, {
	x: 2007,
	y: 177500
}, {
	x: 2005,
	y: 153000
}, {
	x: 2004,
	y: 150000
}, {
	x: 2003,
	y: 150000
}, {
	x: 2000,
	y: 100000
}, {
	x: 1999,
	y: 100500
}, {
	x: 1998,
	y: 100500
}, {
	x: 1997,
	y: 90000
}, {
	x: 1995,
	y: 80000
}, {
	x: 1994,
	y: 80000
}, {
	x: 1993,
	y: 80000
}, {
	x: 1992,
	y: 70000
}, {
	x: 1990,
	y: 70000
}, {
	x: 1989,
	y: 65000
}, {
	x: 1987,
	y: 60000
}, {
	x: 1986,
	y: 60000
}, {
	x: 1985,
	y: 40000
}, {
	x: 1984,
	y: 35000
}, {
	x: 1983,
	y: 30000
}, {
	x: 1982,
	y: 25000
}, {
	x: 1981,
	y: 18000
}, {
	x: 1979,
	y: 12000
}, {
	x: 1978,
	y: 500
}, {
	x: 1971,
	y: 12000
}, {
	x: 1970,
	y: 1500
}];

seriesData[1] = [{
	x: 2011,
	y: 195
}, {
	x: 2010,
	y: 185
}, {
	x: 2008,
	y: 175
}, {
	x: 2007,
	y: 145
}, {
	x: 2005,
	y: 125
}, {
	x: 2004,
	y: 112.00
}, {
	x: 2003,
	y: 105
}, {
	x: 2002,
	y: 97
}, {
	x: 2000,
	y: 87
}, {
	x: 1999,
	y: 83
}, {
	x: 1998,
	y: 80
}, {
	x: 1997,
	y: 75
}, {
	x: 1995,
	y: 70
}, {
	x: 1994,
	y: 64
}, {
	x: 1993,
	y: 62
}, {
	x: 1992,
	y: 53
}, {
	x: 1990,
	y: 41
}, {
	x: 1989,
	y: 30
}, {
	x: 1987,
	y: 21
}, {
	x: 1986,
	y: 18
}, {
	x: 1985,
	y: 16.90
}, {
	x: 1984,
	y: 13.8
}, {
	x: 1983,
	y: 12.8
}, {
	x: 1982,
	y: 8
}, {
	x: 1981,
	y: 8
}, {
	x: 1979,
	y: 5
}, {
	x: 1970,
	y: 1
}];


function compare(a,b) {
  if (a.x < b.x)
     return -1;
  if (a.x > b.x)
    return 1;
  return 0;
}

seriesData[0].sort(compare);
seriesData[1].sort(compare);


// hand made scales, could use max and min to get the right values
var scaleA = d3.scale.linear().domain([0, 200000]);
var scaleP = d3.scale.linear().domain([0, 200]);




var graph = new Rickshaw.Graph( {
	element: document.getElementById("chart"),
	width: 960,
	height: 500,
	renderer: 'line',
	series: [
		{
			color: "#c05020",
			data: seriesData[0],
			name: 'Attendance',
			scale: scaleA
		}, {
			color: "#30c020",
			data: seriesData[1],
			name: 'Price',
			scale: scaleP
		}
	]
} );



var x_ticks = new Rickshaw.Graph.Axis.X( {
	graph: graph,
	element: document.getElementById('x_axis'),
} );


graph.render();

var hoverDetail = new Rickshaw.Graph.HoverDetail( {
	graph: graph
} );

var legend = new Rickshaw.Graph.Legend( {
	graph: graph,
	element: document.getElementById('legend')

} );

var shelving = new Rickshaw.Graph.Behavior.Series.Toggle( {
	graph: graph,
	legend: legend
} );

var axes = new Rickshaw.Graph.Axis.Time( {
	graph: graph
} );
axes.render();

