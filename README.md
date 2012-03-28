# Node Mongo Paginator

This is an uber simple class for helping with pagination. No magic, just works.

## Router/Controller

If you're using [Mongoose](http://mongoosejs.com/):

```coffeescript
Paginator = require('node-mongo-paginator')

app.get '/', (req, res) ->
  query = Widget.where()
  new Paginator perPage: 10, page: req.query.page, query: query, (paginator) ->
    query.skip(paginator.skip).limit(paginator.limit).run (err, widgets) ->
      res.render 'index.jade',
        widgets: widgets
        paginator: paginator
```

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
