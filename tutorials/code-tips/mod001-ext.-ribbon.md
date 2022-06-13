# MOD001 - ext. Ribbon

This is a recreation of the [Fork me on GitHub ribbon](https://github.com/blog/273-github-ribbons) in CSS, hence resolution-independent.This is a recreation of the [Fork me on GitHub ribbon](https://github.com/blog/273-github-ribbons) in CSS, hence resolution-independent.

{% embed url="https://github.com/simonwhitaker/github-fork-ribbon-css" %}

### Using "Fork me on GitHub" CSS ribbon with a CDN

You can use github-fork-ribbon-css without installation via [cdnjs.com](https://cdnjs.com/libraries/github-fork-ribbon-css).

Copy the following code into the `<head>` of your page:

```
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-fork-ribbon-css/0.2.3/gh-fork-ribbon.min.css" />
```

And this into the `<body>` of your page:

```
<a class="github-fork-ribbon" href="https://piergiorgio.gitbook.io/gistips-academy/" data-ribbon="GISTIPS-Academy" title="GISTIPS-Academy">GISTIPS-Academy</a>
```

{% embed url="https://codepen.io/pjhooker/pen/YzxgWXX" %}

### Use Ribbon as ext

Create ./js/script002.js with the following code and insert as "External Scripts":

```
$( document ).ready(function() {
  $('body').append('<a '
    +'class="github-fork-ribbon" '
    +'href="https://piergiorgio.gitbook.io/gistips-academy/" '
    +'data-ribbon="GISTIPS-Academy" '
    +'title="GISTIPS-Academy"> '
    +'GISTIPS-Academy '
  +'</a>');
});
```

{% embed url="https://codepen.io/pjhooker/pen/rNzRWbr" %}
