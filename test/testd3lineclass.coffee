describe("TEST D3line class", ->
  describe('set data', ->
    beforeEach(->
      render()
      this.visualisation = document.querySelector('.d3linesvg')
      this.d3line = new D3Line(this.visualisation)
    )
    it("width is set with right data", ->
      result = this.d3line.width
      assert(result == 500*0.8)
    )
  )
  describe('call function', ->
    beforeEach(->
      render()
      this.visualisation = document.querySelector('.d3linesvg')
    )
    it('draw called once', ->
      d3line = new D3Line(this.visualisation)
      mock = sinon.mock(d3line)
      mock.expects("drawline").once().returns(3)
      result = d3line.draw()
      console.log(result)
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