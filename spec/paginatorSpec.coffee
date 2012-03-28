Paginator = require __dirname + '/../lib/paginator'

describe 'Paginator', ->

  query = null
  paginator = null

  beforeEach ->
    query =
      count: jasmine.createSpy('count').andCallFake (cb) ->
        cb(null, 100)

  it 'passes a new Paginator object to the callback', ->
    runs ->
      new Paginator perPage: 10, page: null, query: query, (p) ->
        paginator = p
    waitsFor (-> paginator)
    runs ->
      expect(paginator instanceof Paginator).toBeTruthy()

  it 'queries for the total', ->
    runs ->
      new Paginator perPage: 10, page: null, query: query, (p) ->
        paginator = p
    waitsFor (-> paginator)
    runs ->
      expect(query.count).toHaveBeenCalled()
      expect(paginator.total).toEqual(100)

  describe 'given pperPage=10 and age=null', ->
    beforeEach ->
      runs ->
        new Paginator perPage: 10, page: null, query: query, (p) ->
          paginator = p
      waitsFor (-> paginator)

    it 'sets skip=0', ->
      runs ->
        expect(paginator.skip).toEqual(0)

  describe 'given perPage=10 and page=0', ->
    beforeEach ->
      runs ->
        new Paginator perPage: 10, page: '0', query: query, (p) ->
          paginator = p
      waitsFor (-> paginator)

    it 'sets skip=0', ->
      runs ->
        expect(paginator.skip).toEqual(0)

  describe 'given perPage=10 and page=2', ->
    beforeEach ->
      runs ->
        new Paginator perPage: 10, page: 2, query: query, (p) ->
          paginator = p
      waitsFor (-> paginator)

    it 'sets skip=10', ->
      runs ->
        expect(paginator.skip).toEqual(10)
