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
  describe('draw', ->
    beforeEach(->
      render()
      this.visualisation = document.querySelector('.d3linesvg')
      this.d3line = new D3Line(this.visualisation)
    )
    it('draw called once', ->
    )
  )
)


render = ->
  svg = d3.select('body').append('svg')
      .attr('class', 'd3linesvg')
      .attr('height', '500')
      .attr('width', '500')