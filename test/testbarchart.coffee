describe("Test D3.js with jasmine", ->
  beforeEach(->
    this.c = new barChart()
    this.testData = [{ date: '2014-01', value: 100}, { date: '2014-02', value: 140}, {date: '2014-03', value: 215}]
    this.c.setData(this.testData)
    this.c.render()
  )
  afterEach(->
    d3.selectAll('svg').remove()
  )
  describe('the svg', ->
    it("should be created", ->
      result = getsvg()
      assert(result!=null)
    )
    it('should have the correct height', ->
      result = getsvg().attr('height')
      assert(result=='500')
    )
    it('should have the correct width', ->
      result = getsvg().attr('width')
      assert(result=='500')
    )
  )
  describe('working with data', ->
    it('should be able to update the data', ->
      result = this.c.getData()
      assert(result==this.testData)
    )
  )
  describe("create bars", ->
    it('should render the correct number of bars', ->
      result = getBars().length
      assert(result==3)
    )
    it('should render the bars with correct height', ->
      result = d3.select(getBars()[0]).attr('height')
    )

  )
)
getsvg = ->
  d3.select('svg')

getBars = ->
  d3.selectAll('rect.bar')[0]