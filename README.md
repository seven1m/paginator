# Paginator.coffee

This is an uber simple class for helping with pagination. No magic, just works.

I use it with Node.js and [Mongoose](http://mongoosejs.com/), but it really has no dependency on Mongo nor on Node.js, so it should work anywhere CoffeeScript/JavaScript works. YMMV.

## Install with NPM

Add to your project's package.json:

```json
{
  "dependencies": {
    "paginator": "git://github.com/seven1m/paginator.git"
  }
}
```

And run:

`npm install`

## Router/Controller

If you're using Mongoose:

```coffeescript
Paginator = require('paginator')
_ = require('underscore')

app.get '/', (req, res) ->
  query = Widget.where('status', 'pending')
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
