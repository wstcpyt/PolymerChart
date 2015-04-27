describe("TEST D3line class", ->
  beforeEach(->
    render()
    this.visualisation = document.querySelector('.d3linesvg')
    this.d3line = new D3Line(this.visualisation, data1, data2)
  )
  describe('set data', ->
    it('visualization is setted', ->
      assert(this.d3line.visualization != undefined )
    )
    it("width is set with right data", ->
      result = this.d3line.width
      assert.equal(result, 500)
    )
    it("height is set with right data", ->
      result = this.d3line.height
      assert.equal(result, 500)
    )
    it("margin is set", ->
      topmargin = this.d3line.margins.top
      assert.equal(topmargin, 20)
    )
    it("data is set", ->
      dataset1 = this.d3line.dataset1
      dataset2 = this.d3line.dataset2
      assert.equal(dataset1[0].year, 2000)
      assert.equal(dataset2[0].year, 2000)
    )
  )
  describe('draw', ->
    it('method is called', ->
      mock = sinon.mock(this.d3line)
      mock.expects('_set_axis').once()
      mock.expects('_set_scale').once()
      mock.expects('_draw_line').once()
      mock.expects('_getLineData1').once()
      mock.expects('_getLineData2').once()
      mock.expects('_animatePath').once()
      this.d3line.draw()
      mock.verify()
      mock.restore()
    )
  )
  describe('_set_scale', ->
    beforeEach(->
      this.d3line._set_scale()
    )
    it('set xScale', ->
      assert.equal(this.d3line.xScale(2000), this.d3line.margins.left)
      assert.equal(this.d3line.xScale(2010), this.d3line.width-this.d3line.margins.right)
      assert.equal(this.d3line.xScale(2004), 222)
    )
    it('set yScale', ->
      assert(this.d3line.yScale(134) == this.d3line.height-this.d3line.margins.bottom)
      assert(this.d3line.yScale(215) == this.d3line.margins.top)
    )
  )
  describe('_set_axis', ->
    it('method is called', ->
      mock = sinon.mock(this.d3line)
      mock.expects('_set_axis_scale').once()
      mock.expects('_call_axis').once()
      this.d3line._set_axis()
      mock.verify()
      mock.restore()
    )
    it('set xaxis', ->
      mock = sinon.mock(this.d3line)
      mock.expects('_call_axis').once().returns(1)
      this.d3line._set_axis()
      result = d3.select('.x.axis').attr('transform')
      assert.equal(result, 'translate(0,480)')
      mock.verify()
      mock.restore()
    )
    it('set yaxis', ->
      mock = sinon.mock(this.d3line)
      mock.expects('_call_axis').once().returns(1)
      this.d3line._set_axis()
      result = d3.select('.y.axis').attr('transform')
      assert.equal(result, 'translate(50,0)')
      mock.verify()
      mock.restore()
    )
  )
  describe('_setresponsive', ->
    it('call method', ->
      mock = sinon.mock(this.d3line)
      mock.expects('_set_scale').once()
      mock.expects('_set_axis_scale').once()
      mock.expects('_call_axis').once()
      mock.expects('_updataLineData').once()
      mock.expects('_getLineData1').once()
      mock.expects('_getLineData2').once()
      mock.expects('_updateAnimate').once()
      this.d3line._setresponsive()
      mock.verify()
      mock.restore()
    )
    it('_updataLineData', ->
      this.d3line.draw()
      this.d3line._updataLineData(1, 1)
      assert.equal(this.d3line.dataset1line.attr('d'), '1')
    )
    it('_updateAnimate', ->
      this.d3line.draw()
      this.d3line._updateAnimate()
      assert.equal(this.d3line.dataset1line.attr('stroke-dasharray'), 0)
      assert.equal(this.d3line.dataset2line.attr('stroke-dasharray'), 0)
      assert.equal(this.d3line.dataset1line.attr('stroke-dashoffset'), 0)
      assert.equal(this.d3line.dataset2line.attr('stroke-dashoffset'), 0)
    )
  )

  describe('_draw_line', ->
    it('dataset1line', ->
      this.d3line._set_scale()
      this.d3line._draw_line(1, 2)
      assert.equal(this.d3line.dataset1line.attr('fill'), 'none')
    )
    it('_getLineData1', ->
      this.d3line._set_scale()
      result = this.d3line._getLineData1()
      assert.equal(result, 'M50,480')
    )
    it('_getLineData2', ->
      this.d3line._set_scale()
      result = this.d3line._getLineData2()
      assert.equal(result, 'M50,480')
    )
  )

  describe('_animatePath', ->
    it('_getLine1TotalLength', ->
      mock = sinon.mock(this.d3line)
      mock.expects('_getLine1TotalLength').once().returns(1)
      mock.expects('_getLine2TotalLength').once().returns(1)
      this.d3line._set_scale()
      this.d3line._draw_line()
      this.d3line._animatePath()
      mock.verify()
      mock.restore()
    )
  )
)

render = ->
  svg = d3.select('body').append('svg')
      .attr('class', 'd3linesvg')
      .attr('height', '500')
      .attr('width', '500')

data1 = [{year:2000, sale:134}]
data2 = [{year:2000, sale:134}]