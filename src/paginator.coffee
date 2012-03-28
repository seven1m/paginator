class Paginator

  constructor: (config) ->
    @limit = @perPage = config.perPage
    @query = config.query
    @window = config.window || 10
    @count = config.count
    @pageCount = Math.floor(@count / @perPage)
    @pageCount++ unless @count % @perPage == 0
    @setPage(config.page)

  setPage: (page) ->
    @page = parseInt(page) || 1
    @page = @pageCount if @page > @pageCount
    @skip = (@page - 1) * @perPage

  pageLinks: ->
    if @pageCount > 0
      start = Math.max(1, @page - @window/2)
      stop = Math.min(@pageCount, start + @window)
      links = (@pageLink(page) for page in [start..stop])
      if start > 1
        links.unshift '...' if start > 2
        links.unshift @pageLink(1)
      if stop < @pageCount
        links.push '...' if stop < @pageCount - 1
        links.push @pageLink(@pageCount)
      "<span class='paginator-intro'>page:</span> #{links.join(' ')}"

  pageLink: (page) ->
    if @page == page
      "<strong class='page-link'>#{page}</strong>"
    else
      "<a class='page-link' href='?page=#{page}'>#{page}</a>"


module.exports = Paginator
