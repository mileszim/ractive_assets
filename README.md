ractive-rails
=============

### Server side

```ruby
gem ractive-rails
```

Add the javascript to your HTML page:

```ruby
 javascript_include_tag "......?"
```
Where you can choose either:
 * ractive -- this contains no support for older browsers and lets you generate ractive templates in the browser
 * ractive.runtime -- this contains no support for older browsers and does not let you generate templates browser-side
 * ractive-legacy -- this contains support for older browsers and lets you generate ractive templates in the browser
 * ractive-legacy.runtime -- this contains support for older browsers and does not let you generate templates browser-side


Include the view templates in the asset pipeline:
```javasript
 //= require_tree ./views
```

### Extensions supported

```
template.rac
template.ractive
```

### Client side

```javascript
var template = RactiveTemplates["path/to/your/template"]
```
