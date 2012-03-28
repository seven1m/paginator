# Paginator.coffee

This is an uber simple class for helping with pagination. No magic, just works.

## Router/Controller

If you're using [Mongoose](http://mongoosejs.com/):

```coffeescript
Paginator = require('paginator')
_ = require('underscore')

app.get '/', (req, res) ->
  query = Widget.where()
  _.clone(query).count (err, count) ->
    paginator = new Paginator perPage: 10, page: req.query.page, count: count
    query.skip(paginator.skip).limit(paginator.limit).run (err, widgets) ->
      res.render 'index.jade',
        widgets: widgets
        paginator: paginator
```

*It seems with Mongoose you have to `clone` the query object for the `count`, otherwise it will be unusable for the subsequent query.*

## View Helper

Generates the numbered links under your listing.

[Jade](http://jade-lang.com/):

```jade
  p!= paginator.pageLinks()
```

[EJS](http://embeddedjs.com/)

```ejs
  <%- paginator.pageLinks() %>
```
