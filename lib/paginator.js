(function() {
  var Paginator;

  Paginator = (function() {

    function Paginator(config) {
      this.limit = this.perPage = config.perPage;
      this.page = parseInt(config.page) || 1;
      this.skip = (this.page - 1) * this.perPage;
      this.count = config.count;
      this.window = config.window || 10;
    }

    Paginator.prototype.pageLinks = function() {
      var links, page, pages, start, stop;
      pages = Math.floor(this.count / this.perPage);
      if (this.count % this.perPage !== 0) pages++;
      if (pages > 0) {
        start = Math.max(1, this.page - this.window / 2);
        stop = Math.min(pages, start + this.window);
        links = (function() {
          var _results;
          _results = [];
          for (page = start; start <= stop ? page <= stop : page >= stop; start <= stop ? page++ : page--) {
            _results.push(this.pageLink(page));
          }
          return _results;
        }).call(this);
        if (start > 1) {
          if (start > 2) links.unshift('...');
          links.unshift(this.pageLink(1));
        }
        if (stop < pages) {
          if (stop < pages - 1) links.push('...');
          links.push(this.pageLink(pages));
        }
        return "<span class='paginator-intro'>page:</span> " + (links.join(' '));
      }
    };

    Paginator.prototype.pageLink = function(page) {
      if (this.page === page) {
        return "<strong class='page-link'>" + page + "</strong>";
      } else {
        return "<a class='page-link' href='?page=" + page + "'>" + page + "</a>";
      }
    };

    return Paginator;

  })();

  module.exports = Paginator;

}).call(this);
