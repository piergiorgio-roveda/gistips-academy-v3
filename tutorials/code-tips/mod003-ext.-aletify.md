# MOD003 - ext. Aletify

AlertifyJS is a javascript framework for developing pretty browser dialogs and notifications.&#x20;

{% embed url="https://alertifyjs.com" %}

{% hint style="info" %}
github.io [https://piergiorgio-roveda.github.io/gistips-academy/gis/tutorials/mod003.html](https://piergiorgio-roveda.github.io/gistips-academy/gis/tutorials/mod003.html)

codepen.io [https://codepen.io/pjhooker/pen/zYdbdpK](https://codepen.io/pjhooker/pen/zYdbdpK)
{% endhint %}

To add ext. Alertify, there are 2 Stylesheets and one Script

```
<!-- CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
```

```
<!-- JavaScript -->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
```

Then create 2 other Script. In the first put a generic function for Dialog ./js/script004.js

```
function create_dialog(single_content,title,dialog_slug){

	alertify.infoDialog || alertify.dialog('infoDialog',function(){
		return {
			main:function(single_content,title,dialog_slug){
				this.setHeader(title);
				this.setContent(single_content);
			},
      setup:function(){
          return { 
            buttons:[{text: "cool!", key:27/*Esc*/}],
            focus: { element:0 }
          };
      }		
		}
	});
	alertify.infoDialog(single_content,title,dialog_slug);
}
```

The second is an example function that work on "map click" ./js/script005.js

```
mymap.on('click', on_click);

function on_click(){
	create_dialog('Test','Title','dlg_home_01');
}
```
