# Create new map

[> GTA-v3](../README.md) [> Manual](README.md)
* * *

1. Create new file in "wp-content/themes/watchdog-child-mvp/meta/webgis" like "template06.php"
2. Copy content of "default00.php"
3. Go to "wp-content/plugins/whatchdog-settings-mvp/watchdog-settings-define\_pages\_webapp.php"
4. Append to SECTION WEBGIS a new cofiguration:

```
  $slug='template99';
  $arr[]=array(
    $slug=>watchdog_pages_webapp_default(array(
      'parent'=>$parent,
      'title' => 'New map',
      'canonical' => site_url( '/'.$parent.'/'.$slug.'/', 'https' ),
      'published' => '2021-12-08T08:00:00+00:00',
      'modified' => '2021-12-08T08:00:00+00:00',
      'image' => 'https://www.cityplanner.biz/wp-content/uploads/2021/08/Thumbnail-v0.3.jpg',
    )),
  ); 
```

The "New map" is ready at the following link: [https://www.cityplanner.biz/webgis/template06/](https://www.cityplanner.biz/webgis/template06/).

The "default00.php" file load some layer, but you can customize these as you want by change $m=array...
