# How to use CSS Sprites with LeafletJS icons

[> GTA-v3](../README.md) [> Technical articles](README.md)
* * *

## Resource
- [Google fonts - Press Start 2P](https://fonts.google.com/specimen/Press+Start+2P?preview.text=1%202%2034%20566%2088&preview.text_type=custom#standard-styles)

## RPG icons

- https://admurin.itch.io/pixel-armory
- https://opengameart.org/content/various-inventory-24-pixel-icon-set
- https://opengameart.org/content/assorted-32x32-creatures

## assorted-32x32-creatures

![assorted-32x32-creatures](https://dev.cityplanner.biz/source/icon/opengameart-org-AndHeGames-creatures_3.png)

![armory](https://dev.cityplanner.biz/source/icon/admurin-itch-iopixel-armory-skWNXS_48x48.png)

## CSS Image Sprites

Use [CSS Image Sprites](https://www.w3schools.com/css/css_image_sprites.asp) is simple and there is a lot of resources that it can used.

LeafletJS, natively don\'t use sprite, but it\'s possibile to use single image for icon.

### Markers With Custom Icons

In [this tutorial](https://leafletjs.com/examples/custom-icons/), you’ll learn how to easily define your own icons for use by the markers you put on the map.

```javascript
var greenIcon = L.icon({
    iconUrl: \'leaf-green.png\',
    shadowUrl: \'leaf-shadow.png\',

    iconSize:     [38, 95], // size of the icon
    shadowSize:   [50, 64], // size of the shadow
    iconAnchor:   [22, 94], // point of the icon which will correspond to marker\'s location
    shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
});
```

Now putting a marker with this icon on a map is easy:

```javascript
L.marker([51.5, -0.09], {icon: greenIcon}).addTo(map);
```

But it\'s possibile use a `<div>` tag instead of defaul icon.

[DivIcon](https://docs.eegeo.com/eegeo.js/v0.1.780/docs/leaflet/L.DivIcon/) - Represents a lightweight icon for markers that uses a simple div element instead of an image.

```javascript
var myIcon = L.divIcon({className: \'my-div-icon\'});
// you can set .my-div-icon styles in CSS

L.marker([50.505, 30.57], {icon: myIcon}).addTo(map);
```

In my example I create a CSS style like this:

```css
.cluster_lyr0_sprite {
    width: 32px;
    height:32px;
    background-position:0 0;
    background: url(/source/icon/opengameart-org-AndHeGames-creatures_3.png);
}
```

I load a point from geojson source

```javascript
var geojson = L.geoJson(r,{
    pointToLayer: geo_lyr0_style_sprite
});
geo_lyr.addLayer(geojson);    

// FINAL ADD!
geo_lyr.addTo(mymap);
```  

I call the function `geo_lyr0_style_sprite` and catch the `creatures_type` param

```javascript
function geo_lyr0_style_sprite(feature,latlng) {
    var myType = feature.properties.creatures_type;
    var myclass = \'cluster_lyr0_sprite\';
    return L.marker(
        latlng,
        {
            icon:createSpriteIcon(myType,myClass),
        }
    );
}
```  

the `creatures_type` param is useful for change sprite

```javascript
var createSpriteIcon = function(myType,myClass){
    return L.divIcon({
        className: \'none\',
        html: \'<div class="\'+ myclass+\' \'+ myType + \'"></div>\' ,
        iconSize: null,
        iconAnchor:[16,32]
    })
}
```

After load lyr I change the sprite with 2nd class

```javascript
$(\'.accounting\').css(\'background-position\',\'\'+(0*32)+\'px -\'+(0*32)+\'px\'); //horizontal vertical
$(\'.business-development\').css(\'background-position\',\'\'+(1*32)+\'px -\'+(0*32)+\'px\');
$(\'.human-resources\').css(\'background-position\',\'\'+(2*32)+\'px -\'+(0*32)+\'px\');
$(\'.research-and-development\').css(\'background-position\',\'\'+(3*32)+\'px -\'+(0*32)+\'px\');
$(\'.services\').css(\'background-position\',\'\'+(4*32)+\'px -\'+(0*32)+\'px\');
$(\'.support\').css(\'background-position\',\'\'+(5*32)+\'px -\'+(0*32)+\'px\');
```    

## Result

[![Imgur](https://www.cityplanner.biz/media/210429_leafletjs_rpg.png)](https://i.imgur.com/bz5HsUx.gifv)
|:--:| 
| *LeafletJS with Sprite icons in actions!* |