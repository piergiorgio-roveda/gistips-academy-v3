# StravaHeatmap Tiles

[> GTA-v3](../README.md) [> Technical articles](README.md)
* * *

From [strava.com](https://www.strava.com/heatmap#10.11/-121.51901/38.46918/hot/all) to your Desktop.

Suggestion of [this web map](https://nakarte.me/#m=13/45.48029/9.20208).

If the follow image work, the service works!

![StravaHeatmap Tiles example](https://proxy.nakarte.me/https/heatmap-external-a.strava.com/tiles-auth/all/hot/15/17217/11725.png?px=256)

For load these tile in QGIS you can add the following url in "XYZ Connections".

```
https://proxy.nakarte.me/https/heatmap-external-a.strava.com/tiles-auth/all/hot/%7Bz%7D/%7Bx%7D/%7By%7D.png
```

([Strava datasheet](https://github.com/piergiorgio-roveda/gistips-academy/blob/main/datasheets/datasheets-01/datasheet-geodata-basemap-strava.md))

## StravaHeatmap Tiles in QGIS example

![StravaHeatmap Tiles in QGIS example](https://www.cityplanner.biz/media/C210420-qgis-strava-nakarte-proxy.png)

## StravaHeatmap Tiles in QGIS configuration

![StravaHeatmap Tiles in QGIS configuration](https://www.cityplanner.biz/media/C210420-qgis-strava-nakarte-proxy-config.png)

## StravaHeatmap Tiles in JOSM example

![StravaHeatmap Tiles in JOSM example](https://www.cityplanner.biz/media/C210420-josm-strava-nakarte-proxy.png)

More info about read [High Resolution Strava Global Heatmap in JOSM](https://nuxx.net/blog/2020/05/24/high-resolution-strava-global-heatmap-in-josm/)
