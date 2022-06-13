---
description: EXT is like "extension" or/and "external"
---

# MOD000 - Prepare ext.

In your code, you can see in codepen.io Pen editor:

```
var map = L.map('map').setView([51.505, -0.09], 13);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);
```

but if you are in your website, this code is like this:

```
<!DOCTYPE html>
<html>
  <head>

    <title>Quick Start - Leaflet</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/x-icon" href="docs/images/favicon.ico" />

    <!-- Pen settings External Stylesheets -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />

    <!--Box CSS di codepen.io Pen editor-->
    <style>
      #mapid {
        height: 200px;
      }
    </style>

  </head>
  <body>

    <div id="mapid"></div>

    <!-- Pen settings External Scripts -->
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js" ></script>

    <!--Box JS di codepen.io Pen editor-->
    <script>

      var map = L.map('mapid').setView([51.505, -0.09], 13);

      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(map);

    </script>

  </body>
</html>
```

See this example stand-alone.

{% embed url="https://piergiorgio-roveda.github.io/gistips-academy/gis/tutorials/mod000.html" %}

But the "Box JS di codepen.io Pen editor" can be an "External Scripts". This code can be put in separate Javascript file, then insert as "External Scripts". Also "Box CSS di codepen.io Pen editor" can be put in "External Stylesheets".

Now create:

* ./css/style000.css
* ./js/script000.js

And view in this example of codepen.io the new files as External Stylesheets/Scripts

{% embed url="https://codepen.io/pjhooker/pen/NWvJrQO" %}

Or the follow in github.io page

{% embed url="https://piergiorgio-roveda.github.io/gistips-academy/gis/tutorials/mod000-1.html" %}

### HTML DOM Manipulation

The DOM is a W3C (World Wide Web Consortium) standard.

The DOM defines a standard for accessing documents:

_"The W3C Document Object Model (DOM) is a platform and language-neutral interface that allows programs and scripts to dynamically access and update the content, structure, and style of a document."_

The W3C DOM standard is separated into 3 different parts:

* Core DOM - standard model for all document types
* XML DOM - standard model for XML documents
* HTML DOM - standard model for HTML documents

{% hint style="info" %}
source: [https://www.w3schools.com/js/js\_htmldom.asp](https://www.w3schools.com/js/js\_htmldom.asp)
{% endhint %}

#### What is the HTML DOM?

The HTML DOM is a standard **object** model and **programming interface** for HTML. It defines:

* The HTML elements as **objects**
* The **properties** of all HTML elements
* The **methods** to access all HTML elements
* The **events** for all HTML elements

In other words: **The HTML DOM is a standard for how to get, change, add, or delete HTML elements.**

#### jQuery vs JavaScript

[jQuery](https://www.w3schools.com/jquery/default.asp) was created in 2006 by John Resig. It was designed to handle Browser Incompatibilities and to simplify HTML DOM Manipulation, Event Handling, Animations, and Ajax.

For more than 10 years, jQuery has been the most popular JavaScript library in the world.

However, after JavaScript [Version 5](https://www.w3schools.com/js/js\_es5.asp) (2009), most of the jQuery utilities can be solved with a few lines of standard JavaScript (example: **** Remove an HTML element):

```
// jQuery
$("#id02").remove();

//JavaScript
document.getElementById("id02").remove();
```

#### JavaScript Version 5 (JavaScript ES5)

**ECMAScript** (or **ES**)[\[1\]](https://en.wikipedia.org/wiki/ECMAScript#cite\_note-1) is a [general-purpose programming language](https://en.wikipedia.org/wiki/General-purpose\_programming\_language), standardised by [Ecma International](https://en.wikipedia.org/wiki/Ecma\_International) according to the document [ECMA-262](https://www.ecma-international.org/publications/standards/Ecma-262.htm). It is a [JavaScript](https://en.wikipedia.org/wiki/JavaScript) standard meant to ensure the interoperability of [web pages](https://en.wikipedia.org/wiki/Web\_page) across different [web browsers](https://en.wikipedia.org/wiki/Web\_browser).[\[2\]](https://en.wikipedia.org/wiki/ECMAScript#cite\_note-2) ECMAScript is commonly used for [client-side scripting](https://en.wikipedia.org/wiki/Client-side\_scripting) on the [World Wide Web](https://en.wikipedia.org/wiki/World\_Wide\_Web), and it is increasingly being used for writing server applications and services using [Node.js](https://en.wikipedia.org/wiki/Node.js).

{% hint style="info" %}
source: [https://en.wikipedia.org/wiki/ECMAScript](https://en.wikipedia.org/wiki/ECMAScript)
{% endhint %}

Leaflet in [2017-08-08](https://leafletjs.com/2017/08/08/leaflet-1.2.0.html) has been released and it was rebuilt on JavaScript ES6 modules. JavaScript ES have a lot of function and jQuery became useless, but a lot of Academy tutorials use jQuery for important reasons.

```
// Javascript ES
const el = document.getElementById('id02');
el.remove();
```

### Enable jQuery

This library can be load as "External Scripts". This tutorial use jQuery Core 3.6.0 minified, found here: [https://code.jquery.com/](https://code.jquery.com)

{% embed url="https://codepen.io/pjhooker/pen/ExvMNQR" %}

It can be test by loading ./js/script001.js that contain:

```
// A $( document ).ready() block.
$( document ).ready(function() {
  alert( "jQuery ready!" );
});
```
