---
kind: article
created_at: "2015-02-23"
title: Using Python to get at the list behind the The Maserati 100
---

I'm lucky enough to have a few friends who made it onto [The Maserati 100](http://www.themaserati100.co.uk), which is very cool.  Unfortunately the website is a wall of faces, which is pretty but shitty to explore.  10 minutes of Python later, here's the list of all those people (with links), and below, the Python code that generated it.

<ul>
  <li><a href="http://www.themaserati100.co.uk/item/adrian-burden/">Adrian Burden</a></li>
<li><a href="http://www.themaserati100.co.uk/item/alistair-cameron/">Alastair Cameron</a></li>
<li><a href="http://www.themaserati100.co.uk/item/alastair-waite/">Alastair Waite</a></li>
<li><a href="http://www.themaserati100.co.uk/item/alex-hoye/">Alex Hoye</a></li>
<li><a href="http://www.themaserati100.co.uk/item/alex-saint/">Alex Saint</a></li>
<li><a href="http://www.themaserati100.co.uk/item/alicia-navarro/">Alicia Navarro</a></li>
<li><a href="http://www.themaserati100.co.uk/item/alison-lewy/">Alison Lewy</a></li>
<li><a href="http://www.themaserati100.co.uk/item/allan-lloyds/">Allan Lloyds</a></li>
<li><a href="http://www.themaserati100.co.uk/item/andrew-bredon/">Andrew Bredon</a></li>
<li><a href="http://www.themaserati100.co.uk/item/andrew-humphries/">Andrew Humphries</a></li>
<li><a href="http://www.themaserati100.co.uk/item/andy-mcloughlin/">Andy Mcloughlin</a></li>
<li><a href="http://www.themaserati100.co.uk/item/ann-gloag/">Ann Gloag</a></li>
<li><a href="http://www.themaserati100.co.uk/item/brent-hoberman/">Brent Hoberman</a></li>
<li><a href="http://www.themaserati100.co.uk/item/brian-chernett/">Brian Chernett</a></li>
<li><a href="http://www.themaserati100.co.uk/item/carrie-green/">Carrie Green</a></li>
<li><a href="http://www.themaserati100.co.uk/item/charlotte-windebank/">Charlotte Windebank</a></li>
<li><a href="http://www.themaserati100.co.uk/item/chris-gorell-barnes/">Chris Gorell Barnes</a></li>
<li><a href="http://www.themaserati100.co.uk/item/cynthia-shanmugalingam/">Cynthia Shanmugalingam</a></li>
<li><a href="http://www.themaserati100.co.uk/item/dale-murray/">Dale Murray</a></li>
<li><a href="http://www.themaserati100.co.uk/item/david-bingle/">David Bingle</a></li>
<li><a href="http://www.themaserati100.co.uk/item/debbie-wosskow/">Debbie Wosskow</a></li>
<li><a href="http://www.themaserati100.co.uk/item/denys-shortt/">Denys Shortt</a></li>
<li><a href="http://www.themaserati100.co.uk/item/dirk-bischof/">Dirk Bischof</a></li>
<li><a href="http://www.themaserati100.co.uk/item/dom-jackman/">Dom Jackman</a></li>
<li><a href="http://www.themaserati100.co.uk/item/duane-jackson/">Duane Jackson</a></li>
<li><a href="http://www.themaserati100.co.uk/item/duncan-cheatle/">Duncan Cheatle</a></li>
<li><a href="http://www.themaserati100.co.uk/item/efe-ezekiel/">Efe Ezekiel</a></li>
<li><a href="http://www.themaserati100.co.uk/item/emma-jones/">Emma Jones</a></li>
<li><a href="http://www.themaserati100.co.uk/item/eric-van-der-kleij/">Eric Van der Kleij</a></li>
<li><a href="http://www.themaserati100.co.uk/item/fay-easton/">Fay Easton</a></li>
<li><a href="http://www.themaserati100.co.uk/item/hak-salih/">Hak Salih</a></li>
<li><a href="http://www.themaserati100.co.uk/item/helen-roberts/">Helen Roberts</a></li>
<li><a href="http://www.themaserati100.co.uk/item/hugh-chappell/">Hugh Chappell</a></li>
<li><a href="http://www.themaserati100.co.uk/item/ian-beaverstock/">Ian Beaverstock</a></li>
<li><a href="http://www.themaserati100.co.uk/item/iqbal-wahhab/">Iqbal Wahhab</a></li>
<li><a href="http://www.themaserati100.co.uk/item/james-taylor/">James Taylor</a></li>
<li><a href="http://www.themaserati100.co.uk/item/jill-white/">Jill White</a></li>
<li><a href="http://www.themaserati100.co.uk/item/jim-cregan/">Jim Cregan</a></li>
<li><a href="http://www.themaserati100.co.uk/item/jim-duffy/">Jim Duffy</a></li>
<li><a href="http://www.themaserati100.co.uk/item/joel-blake/">Joel Blake</a></li>
<li><a href="http://www.themaserati100.co.uk/item/john-frieda/">John Frieda</a></li>
<li><a href="http://www.themaserati100.co.uk/item/john-hunt/">John Hunt</a></li>
<li><a href="http://www.themaserati100.co.uk/item/john-spindler/">John Spindler</a></li>
<li><a href="http://www.themaserati100.co.uk/item/jonathan-pfhal/">Jonathan Pfahl</a></li>
<li><a href="http://www.themaserati100.co.uk/item/jordan-schlipf/">Jordan Schlipf</a></li>
<li><a href="http://www.themaserati100.co.uk/item/julie-deane/">Julie Deane</a></li>
<li><a href="http://www.themaserati100.co.uk/item/kate-craig-wood/">Kate Craig-Wood</a></li>
<li><a href="http://www.themaserati100.co.uk/item/kathryn-parsons/">Kathryn Parsons</a></li>
<li><a href="http://www.themaserati100.co.uk/item/kathy-shenoy/">Kathy Shenoy</a></li>
<li><a href="http://www.themaserati100.co.uk/item/lara-morgan/">Lara Morgan</a></li>
<li><a href="http://www.themaserati100.co.uk/item/lee-strafford/">Lee Strafford</a></li>
<li><a href="http://www.themaserati100.co.uk/item/lord-willie-haughey/">Lord Willie Haughey</a></li>
<li><a href="http://www.themaserati100.co.uk/item/luke-johnson/">Luke Johnson</a></li>
<li><a href="http://www.themaserati100.co.uk/item/mark-sheahan/">Mark Sheahan</a></li>
<li><a href="http://www.themaserati100.co.uk/item/martin-adams/">Martin Adams</a></li>
<li><a href="http://www.themaserati100.co.uk/item/martin-leuw/">Martin Leuw</a></li>
<li><a href="http://www.themaserati100.co.uk/item/matt-truman/">Matt Truman</a></li>
<li><a href="http://www.themaserati100.co.uk/item/michael-acton-smith-obe/">Michael Acton Smith OBE</a></li>
<li><a href="http://www.themaserati100.co.uk/item/michelle-wright/">Michelle Wright</a></li>
<li><a href="http://www.themaserati100.co.uk/item/mike-bartley/">Mike Bartley</a></li>
<li><a href="http://www.themaserati100.co.uk/item/mike-sotirakos/">Mike Sotirakos</a></li>
<li><a href="http://www.themaserati100.co.uk/item/mike-southon/">Mike Southon</a></li>
<li><a href="http://www.themaserati100.co.uk/item/moe-nawaz/">Moe Nawaz</a></li>
<li><a href="http://www.themaserati100.co.uk/item/naomi-timperley/">Naomi Timperley</a></li>
<li><a href="http://www.themaserati100.co.uk/item/neil-cocker/">Neil Cocker</a></li>
<li><a href="http://www.themaserati100.co.uk/item/nicholas-wheeler/">Nicholas Wheeler</a></li>
<li><a href="http://www.themaserati100.co.uk/item/nicky-templeton/">Nicky Templeton</a></li>
<li><a href="http://www.themaserati100.co.uk/item/oli-barrett/">Oli Barrett</a></li>
<li><a href="http://www.themaserati100.co.uk/item/olly-treadway/">Olly Treadway</a></li>
<li><a href="http://www.themaserati100.co.uk/item/paddy-willis/">Paddy Willis</a></li>
<li><a href="http://www.themaserati100.co.uk/item/paul-d-hannon/">Paul D. Hannon</a></li>
<li><a href="http://www.themaserati100.co.uk/item/paul-rawlings/">Paul Rawlings</a></li>
<li><a href="http://www.themaserati100.co.uk/item/paul-smith/">Paul Smith</a></li>
<li><a href="http://www.themaserati100.co.uk/item/peter-cowley/">Peter Cowley</a></li>
<li><a href="http://www.themaserati100.co.uk/item/peter-dubens/">Peter Dubens</a></li>
<li><a href="http://www.themaserati100.co.uk/item/peter-jones-cbe/">Peter Jones CBE</a></li>
<li><a href="http://www.themaserati100.co.uk/item/rachel-mallows/">Rachel Mallows</a></li>
<li><a href="http://www.themaserati100.co.uk/item/rajeeb-dey/">Rajeeb Dey</a></li>
<li><a href="http://www.themaserati100.co.uk/item/raj-ramanandi/">Raj Ramanandi</a></li>
<li><a href="http://www.themaserati100.co.uk/item/richard-hurtley/">Richard Hurtley</a></li>
<li><a href="http://www.themaserati100.co.uk/item/river-tamoor-baig/">River Tamoor Baig</a></li>
<li><a href="http://www.themaserati100.co.uk/item/rob-symes/">Rob Symes</a></li>
<li><a href="http://www.themaserati100.co.uk/item/rob-symington/">Rob Symington</a></li>
<li><a href="http://www.themaserati100.co.uk/item/rob-wirscycz/">Rob Wirscycz</a></li>
<li><a href="http://www.themaserati100.co.uk/item/robert-wilson/">Robert Wilson</a></li>
<li><a href="http://www.themaserati100.co.uk/item/rod-banner/">Rod Banner</a></li>
<li><a href="http://www.themaserati100.co.uk/item/rose-lewis/">Rose Lewis</a></li>
<li><a href="http://www.themaserati100.co.uk/item/russ-shaw/">Russ Shaw</a></li>
<li><a href="http://www.themaserati100.co.uk/item/russell-dalgleish/">Russell Dalgleish</a></li>
<li><a href="http://www.themaserati100.co.uk/item/shaa-wasmund/">Shaa Wasmund</a></li>
<li><a href="http://www.themaserati100.co.uk/item/sherry-coutu/">Sherry Coutu</a></li>
<li><a href="http://www.themaserati100.co.uk/item/simon-campbell/">Simon Campbell</a></li>
<li><a href="http://www.themaserati100.co.uk/item/simon-devonshire/">Simon Devonshire</a></li>
<li><a href="http://www.themaserati100.co.uk/item/sir-charles-dunstone/">Sir Charles Dunstone</a></li>
<li><a href="http://www.themaserati100.co.uk/item/richard-branson/">Sir Richard Branson</a></li>
<li><a href="http://www.themaserati100.co.uk/item/sir-tom-hunter/">Sir Tom Hunter</a></li>
<li><a href="http://www.themaserati100.co.uk/item/sokratis-papafloratos/">Sokratis Papafloratos</a></li>
<li><a href="http://www.themaserati100.co.uk/item/timothy-barnes/">Timothy Barnes</a></li>
<li><a href="http://www.themaserati100.co.uk/item/victoria-olubi/">Victoria Olubi</a></li>
<li><a href="http://www.themaserati100.co.uk/item/wendy-tan-white/">Wendy Tan White</a></li>

</ul>

    from bs4 import BeautifulSoup
    import requests
    r  = requests.get("http://www.themaserati100.co.uk/")
    data = r.text
    soup = BeautifulSoup(data)
    for portfolio in soup.find_all('div', class_="portfolio-item"):
      print ("<li><a href=\"%s\">%s</a></li>" % (portfolio.a.get("href"), portfolio.img.get("alt")))
