# Leaflet Quick Start Guide

This tutorial is inspired by [https://leafletjs.com/examples/quick-start/](https://leafletjs.com/examples/quick-start/).

This step-by-step guide will quickly get you started on Leaflet basics, including setting up a Leaflet map.

{% embed url="https://codepen.io/pjhooker/pen/VwzReez" %}

### Preparing your page <a href="preparing-your-page" id="preparing-your-page"></a>

Before writing any code for the map, you need to do the following preparation steps on your page:

* Include Leaflet CSS file in the head section of your document:

```
 <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
   integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
   crossorigin=""/>
```

* Include Leaflet JavaScript file **after** Leaflet’s CSS:

```
<!-- Make sure you put this AFTER Leaflet's CSS -->
 <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
   integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
   crossorigin=""></script>
```

* Put a `div` element with a certain `id` where you want your map to be:

```
<div id="map"></div>
```

* Make sure the map container has a defined height, for example by setting it in CSS:

```
#map { height: 200px; }
```

Now you’re ready to initialize the map and do some stuff with it.

### Setting up the map <a href="setting-up-the-map" id="setting-up-the-map"></a>

Let’s create a map of the center of London with pretty Mapbox Streets tiles. First we’ll initialize the map and set its view to our chosen geographical coordinates and a zoom level:

```
var mymap = L.map('map').setView([51.505, -0.09], 13);
```

Next, we’ll add a tile layer to add to our map, in this case it’s a OpenStreetMap Mapnik tile layer. Creating a tile layer usually involves setting the [URL template](https://leafletjs.com/reference.html#tilelayer-url-template) for the tile images, the attribution text, and the maximum zoom level of the layer.

```
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);
```

Make sure all the code is called after the `div` and `leaflet.js` inclusion. That’s it! You have a working Leaflet map now.

Whenever using anything based on OpenStreetMap, an _attribution_ is obligatory as per the [copyright notice](https://www.openstreetmap.org/copyright). Most other tile providers (such as [Mapbox](https://docs.mapbox.com/help/how-mapbox-works/attribution/), [Stamen](http://maps.stamen.com) or [Thunderforest](https://www.thunderforest.com/terms/)) require an attribution as well. Make sure to give credit where credit is due.
