# Tutorial: download Open Street Map data

[> GTA-v3](../README.md) [> Technical articles](README.md)
* * *

OSM (Open Street Map) is a great international project where all we can map the world.

There is a community around this project and we can contribute in various ways:

1. using as a map navigation
2. exploring map from cities to mountain hiking path
3. mapping buildings, streets and pois of your city with a GIS software or directly from browser
4. developing an app solutions with a lot of manuals and tutorials
5. download geo-data and use for all your needs

This last point is the main content of this tutorial, because it isn\'t immediate to do.

In this case I must use Ubuntu Linux, but you can follow on Windows machine with similar command.

## Requirements

1. QGIS
2. internet connection
3. 25GB free space on your hard disk
4. privileges to install software

If you don\'t have QGIS software you can watch this video tutorial: https://youtu.be/robhhEqdNGU

## Summary

1. download OSM region from geofabrik.de
2. convert OSM native format *.pbf to a common file format *.osm
3. choose an elements that you need with filtering
4. convert filtering elements to *.geojson file format
5. load *.geojson files into QGIS
6. save *.geojson files to *.spatialite for more versatility

# Download OSM region from geofabrik.de

You can download all the world geo-data from this site: http://download.geofabrik.de/index.html

But I prefer to download a single region Italy-Nord-Ovest from here: https://osm-internal.download.geofabrik.de/europe/italy/nord-ovest.html

There is some file format, but for this tutorial, you must download *.pbf file, because is the best to discovery all attributes.

# Convert OSM native format *.pbf to a common file format *.osm

To use the downloaded file, you must convert from *.pbf to a common file format *.osm

You can follow the instruction to get Osmconverter here: https://wiki.openstreetmap.org/wiki/Osmconvert#Linux

For Windows user view section https://wiki.openstreetmap.org/wiki/Osmconvert#Windows, where you can download osmconvert64.exe

You can execute this command to convert file

<pre>
<code>
osmconvert /home/pjhooker/Desktop/nord-ovest-internal.osh.pbf  > /home/pjhooker/Desktop/nord-ovest.osm
</code>
</pre>

For Window use osmconvert64.exe instead of osmconvert

In my case the file *.pbf was 780MB and the result *.osm was 24GB!

# Choose an elements that you need with filtering

I want to extract only motorways of region and I read a OSM documentation for specific tags here: https://wiki.openstreetmap.org/wiki/Tag:highway%3Dmotorway

You must install osmfilter for this step https://wiki.openstreetmap.org/wiki/Osmfilter

You can execute this command to filter OSM data

<pre>
<code>
osmfilter /home/pjhooker/Desktop/nord-ovest.osm --keep="highway=motorway =trunk =motorway_link =trunk_link" > nord-ovest_motorway_trunk.osm
</code>
</pre>

# Convert filtering elements to *.geojson file format

There\'s only one step before you can visualize the OSM data with full attributes.

I don\'t found a Windows solution for ogr2ogr, but you can find a solution here: https://gdal.org/programs/ogr2ogr.html

You can execute this command to filter OSM data

```
ogr2ogr -f GeoJSON  /home/pjhooker/Desktop/nord-ovest_motorway_trunk.geojson /home/pjhooker/Desktop/nord-ovest_motorway_trunk.osm lines
```

# Load *.geojson files into QGIS

coming soon

# Save *.geojson files to *.spatialite for more versatility

coming soon 
',//<-yoast
'
# example

osmfilter /home/pjhooker/Desktop/nord-ovest.osm --keep="highway=motorway =trunk =motorway_link =trunk_link" > nord-ovest_motorway_trunk.osm

osmfilter.exe ./milano.osm --keep="shop=supermarket" > milano_shop_supermarket.osm

osmfilter.exe ./milan.osm --keep="shop=supermarket" > ./milan_shop_supermarket.osm
