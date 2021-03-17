---
date: "2020-05-03"
title: Aural Assault
tags: ["project", "javascript", "the prodigy"]
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

Based on something I saw ears ago at The baltic that I've never managed to track down.

{{< rawhtml >}}

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.js" integrity="sha512-WNLxfP/8cVYL9sj8Jnp6et0BkubLP31jhTG9vhL/F5uEZmg5wEzKoXp1kJslzPQWwPT1eyMiSxlKCgzHLOTOTQ==" crossorigin="anonymous"></script>

<a id="play-video" href="#">Bring the noise</a><br/>
 
<iframe id="video" width="420" height="315" src="//www.youtube.com/embed/zKNoU2P0dQc?rel=0" frameborder="0" allowfullscreen></iframe>
<iframe id="video1" width="420" height="315" src="//www.youtube.com/embed/zKNoU2P0dQc?rel=0" frameborder="0" allowfullscreen></iframe>
<iframe id="video2" width="420" height="315" src="//www.youtube.com/embed/zKNoU2P0dQc?rel=0" frameborder="0" allowfullscreen></iframe>
<iframe id="video3" width="420" height="315" src="//www.youtube.com/embed/zKNoU2P0dQc?rel=0" frameborder="0" allowfullscreen></iframe>
<iframe id="video4" width="420" height="315" src="//www.youtube.com/embed/zKNoU2P0dQc?rel=0" frameborder="0" allowfullscreen></iframe>
<iframe id="video5" width="420" height="315" src="//www.youtube.com/embed/zKNoU2P0dQc?rel=0" frameborder="0" allowfullscreen></iframe>
<iframe id="video6" width="420" height="315" src="//www.youtube.com/embed/zKNoU2P0dQc?rel=0" frameborder="0" allowfullscreen></iframe>
<iframe id="video7" width="420" height="315" src="//www.youtube.com/embed/zKNoU2P0dQc?rel=0" frameborder="0" allowfullscreen></iframe>
<iframe id="video8" width="420" height="315" src="//www.youtube.com/embed/zKNoU2P0dQc?rel=0" frameborder="0" allowfullscreen></iframe>




<script type="text/javascript">
	
$(document).ready(function() {
  $('#play-video').on('click', function(ev) {
 
    $("#video")[0].src += "&autoplay=1";
    debugger;
    var counter=1;
    var myVar = setInterval(myTimer, 7000);

	function myTimer() {
		console.log("#video"+counter);
  		 $("#video"+counter)[0].src += "&autoplay=1";
  		 counter++;
  		 console.log("#video"+counter);
	}

   
   
    if(counter==9){
    	clearInterval(myVar);
    }

    ev.preventDefault();
 
  });
});

</script>

{{< /rawhtml >}}