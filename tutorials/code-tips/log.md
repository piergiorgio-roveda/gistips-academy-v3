# Log

## 08/02/2022

The main activities are to upgrade the old version of WebGIS on Wordpress, with the new schema of WebGIS.

* delete functions that create a php module part of map
* substitute all template part functions with one sigle part, with enteire page `<html></html>`
* this new page-map must contain php and javascript code; it contains all javascript and css parts
* in this page-map, all php variables are converted to javascript variables
* api-geodata now use the new watchdog-api
* watchdog-api classes work fine inside the wordpress plugin watchdog-settings
