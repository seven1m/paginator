Paginator = require __dirname + '/../lib/paginator'

describe 'Paginator', ->

  query = null
  paginator = null

  beforeEach ->
    query =
      count: jasmine.createSpy('count').andCallFake (cb) ->
        cb(null, 100)

  it 'stores the count', ->
    paginator = new Paginator perPage: 10, page: null, count: 100
    expect(paginator.count).toEqual(100)

  describe 'given perPage=10 and page=null', ->
    beforeEach ->
      paginator = new Paginator perPage: 10, page: null, count: 100

    it 'sets skip=0', ->
      expect(paginator.skip).toEqual(0)

  describe 'given perPage=10 and page=0', ->
    beforeEach ->
      paginator = new Paginator perPage: 10, page: '0', count: 100

    it 'sets skip=0', ->
      expect(paginator.skip).toEqual(0)

  describe 'given perPage=10 and page=2', ->
    beforeEach ->
      paginator = new Paginator perPage: 10, page: 2, count: 100

    it 'sets skip=10', ->
      expect(paginator.skip).toEqual(10)
