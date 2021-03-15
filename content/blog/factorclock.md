---
date: "2014-03-17"
title: XKCD Inspired Factor Clock
tags: ["javascript","xkcd"]
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

{{< rawhtml >}}
<h2 id="time">TIME</h2>
<h3 id="factors">FACTORS</h3>


<script>

// Factoring code all nabbed from http://www.javascripter.net/math/primes/factorization.htm
function factor(n) {
 if (isNaN(n) || !isFinite(n) || n%1!=0 || n==0) return ''+n;
 if (n<0) return '-'+factor(-n);
 var minFactor = leastFactor(n);
 if (n==minFactor) return ''+n;
 return minFactor+' x '+factor(n/minFactor);
}

function leastFactor(n) {
 if (isNaN(n) || !isFinite(n)) return NaN;
 if (n==0) return 0;
 if (n%1 || n*n<2) return 1;
 if (n%2==0) return 2;
 if (n%3==0) return 3;
 if (n%5==0) return 5;
 var m = Math.sqrt(n);
 for (var i=7;i<=m;i+=30) {
  if (n%i==0)      return i;
  if (n%(i+4)==0)  return i+4;
  if (n%(i+6)==0)  return i+6;
  if (n%(i+10)==0) return i+10;
  if (n%(i+12)==0) return i+12;
  if (n%(i+16)==0) return i+16;
  if (n%(i+22)==0) return i+22;
  if (n%(i+24)==0) return i+24;
 }
 return n;
}


function getTimeAsObj(){
var d = new Date(),
minutes =(String)(d.getMinutes()),
seconds =(String)(d.getSeconds()),
	returned = {};

if (minutes.length === 1) {
	minutes = "0"+minutes;
}

if (seconds.length === 1) {
	seconds = "0"+seconds;
}

returned.timeNumber = parseInt(d.getHours() + minutes + seconds);

returned.timeString = d.getHours() + ":" + minutes + ":" + seconds;

return returned;
}

function updateDisplay(){
	var dateObj = getTimeAsObj(),
		strFactor = factor(dateObj.timeNumber);
	if (strFactor.indexOf("x") === -1){
		strFactor = strFactor + " is prime!";
	}
	document.getElementById("time").innerHTML = dateObj.timeString;
	document.getElementById("factors").innerHTML = strFactor;
}

function dotime(){
	
	var d = new Date();
	var hours = d.getHours();
	var mins = d.getMinutes();
	var secs = d.getSeconds();
	
	if (hours < 10){hours = "0" + hours};
	if (mins < 10){mins = "0" + mins};
	if (secs < 10){secs = "0" + secs};
	
	hours.toString();
	mins.toString();
	secs.toString();
	
	var hex = "#" + hours + mins + secs;
	document.getElementById("time").style.background = hex;
}
	
	setTimeout(function(){ dotime();}, 1000);
	setInterval(updateDisplay,1000);

updateDisplay();

</script>

{{< /rawhtml >}}

  Edited 20-12-14: I ran across this brilliant [What color is it](http://whatcolorisit.sumbioun.com/) and couldn't resist bolting on the rather neat idea of colours based on the time.

Yesterday I found my XKCD book that I was given for Christmas and whilst leafing through it ran across this gem [about factoring the time](https://xkcd.com/247/).


Having an hour spare this morning I could help but built the factor clock above.  View Source for the code, most of which is a little ugly and the factoring code is borrowed (cited in source)





