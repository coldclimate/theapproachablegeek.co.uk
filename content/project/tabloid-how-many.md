---
date: "2020-05-03"
title: Tabloid scale
tags: ["project", "javascript"]
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
<script>
  function setResult(first, second, destination){

  // get the value from item1
    var selector = document.getElementById(first);
    var valueOne = selector[selector.selectedIndex].value;
    var nameOne = selector[selector.selectedIndex].text;

  // get the value from item2
    selector = document.getElementById(second);
    var valueTwo = selector[selector.selectedIndex].value;
    var nameTwo = selector[selector.selectedIndex].text;


  // do maths 
  var result = valueTwo/valueOne;

  // construct sentence
  var sentence = "There are " + result + " " + nameOne + "s in a " + nameTwo ;

  // set sentence
  console.log("#"+destination);
  document.getElementById(destination).innerHTML = sentence;

}


</script>
<select name="length1" id="length1">
        <option value="42195">Marathon</option>
        <option value="8848" selected>Mount Everest</option>
        <option value="120">Football Pitch</option>
        <option value="25">Blue Whale</option>
        <option value="0.138">iPhone 7</option>
    </select>
 in a 
    <select name="length2" id="length2">
        <option value="42195">Marathon</option>
        <option value="8848" selected>Mount Everest</option>
        <option value="120">Football Pitch</option>
        <option value="25">Blue Whale</option>
        <option value="0.138">iPhone 7</option>
    </select>
        <button id="lengthButton" onclick="setResult('length1', 'length2', 'lengthResult')">Go!</button>
        <p><span id="lengthResult"></span></p>

        <select name="area1" id="area1">
        <option value="510072000000" selected>Earth</option>
        <option value="696241000">Texas</option>
        <option value="640679000">France</option>
        <option value="20779000">Wales</option>
        <option value="380000">Isle of Wight</option>
        <option value="7140">Football Pitch</option>
        <option value="1250">Olymic swimming pool</option>
        <option value="75">Blue whale</option>
        <option value="54">Double decker bus</option>
        <option value="0.001426">Matchbox</option>
    </select>
 in a 
    <select name="area2" id="area2">
        <option value="510072000000" selected>Earth</option>
        <option value="696241000">Texas</option>
        <option value="640679000">France</option>
        <option value="20779000">Wales</option>
        <option value="380000">Isle of Wight</option>
        <option value="7140">Football Pitch</option>
        <option value="1250">Olymic swimming pool</option>
        <option value="75">Blue whale</option>
        <option value="54">Double decker bus</option>
        <option value="0.001426">Matchbox</option>
    </select>
        <button id="areaButton" onclick="setResult('area1', 'area2', 'areaResult')" >Go!</button>
        <p><span id="areaResult"></span></p>

{{< /rawhtml >}}