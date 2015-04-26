class @D3Line
  constructor: (@polymerthis) ->
  _init_variable: ->
    this.dataset1 = this.polymerthis.data1
    this.dataset2 = this.polymerthis.data2
    this.visualization = d3.select(this.polymerthis.$.visualisation)
    this.container = d3.select(this.polymerthis.$.svgcontainer)
    this.width = window.outerWidth*0.5
    this.height = 500
    this.margins = {
      top: 20,
      right: 20,
      bottom: 20,
      left: 50
    }
    this.bisectDate = d3.bisector((d) ->
      d.year
    ).left

  draw: ->
    this._set_scale()
    this._set_axis()
    this._set_tooltip()
    this._draw_line()

  _set_tooltip: ->
    _this = this
    this.focus = this.visualization.append("g")
    .attr("class", "focus")
    .style("display", "none")
    this.focus.append("circle")
    .attr("r", 4.5)
    this.focus.append("text")
    .attr("x", 9)
    .attr("dy", ".35em")
    this.visualization.append("rect")
    .attr("class", "overlay")
    .attr("width", this.width)
    .attr("height", this.height)
    .on("mouseover", ->
      _this.focus
      .style("display", null)
    )
    .on("mouseout", ->
      _this.focus
      .style("display", "none")
    )
    .on("mousemove", ->
      x0 = _this.xScale.invert(d3.mouse(this)[0])
      i = _this.bisectDate(_this.dataset1, x0, 1)
      d = _this.dataset1[i-1]
      _this.focus.attr("transform", "translate(" + _this.xScale(d.year) + "," + _this.yScale(d.sale) + ")")
      _this.focus.select("text")
      .text(d.year + ',' + d.sale);
    )


  _set_scale: ->
    this.xScale = d3.scale.linear().range([this.margins.left, this.width - this.margins.right]).domain([2000,2010])
    this.yScale = d3.scale.linear().range([this.height - this.margins.top, this.margins.bottom]).domain([134,215])
  _set_axis: ->
    this._set_axis_scale()
    this.xaxis = this.visualization.append("svg:g")
    .attr("class","axis")
    .attr("transform", "translate(0," + (this.height - this.margins.bottom) + ")")
    this.yaxis = this.visualization.append("svg:g")
    .attr("class","axis")
    .attr("transform", "translate(" + (this.margins.left) + ",0)")
    this._call_axis()
  _call_axis: ->
    this.xaxis.call(this.xAxis)
    this.yaxis.call(this.yAxis)
  _set_axis_scale: ->
    this.xAxis = d3.svg.axis().scale(this.xScale)
    this.yAxis = d3.svg.axis()
    .scale(this.yScale)
    .orient("left")
  _draw_line: ->
    lineGen = this._getlineGen()
    this.dataset1line = this.visualization.append('svg:path')
    .attr('stroke', 'green')
    .attr('stroke-width', 2)
    .attr('fill', 'none')
    .attr('d', lineGen(this.dataset1))
    this.dataset2line = this.visualization.append('svg:path')
    .attr('stroke', 'blue')
    .attr('stroke-width', 2)
    .attr('fill', 'none')
    .attr('d', lineGen(this.dataset2))
    this.totalLength1 = this.dataset1line.node().getTotalLength()
    this.totalLength2 = this.dataset2line.node().getTotalLength()
    this._animatePath()
  _animatePath: ->
    this.dataset1line
    .attr("stroke-dasharray", this.totalLength1 + " " + this.totalLength1)
    .attr("stroke-dashoffset", this.totalLength1)
    .transition()
    .duration(1000)
    .ease("linear")
    .attr("stroke-dashoffset", 0)
    this.dataset2line
    .attr("stroke-dasharray", this.totalLength2 + " " + this.totalLength2)
    .attr("stroke-dashoffset", this.totalLength2)
    .transition()
    .duration(1000)
    .ease("linear")
    .attr("stroke-dashoffset", 0)
  _setdata: (lineGen)->
    this.dataset1line.transition().duration(800).attr('d', lineGen(this.dataset1))
    this.dataset2line.transition().duration(800).attr('d', lineGen(this.dataset2))
  _getlineGen: ->
    _this = this
    d3.svg.line()
    .x((d) ->
      _this.xScale(d.year))
    .y((d) ->
      _this.yScale(d.sale))
  _setresponsive: ->
    this._set_scale()
    this._set_axis_scale()
    this._call_axis()
    lineGen = this._getlineGen()
    this._setdata(lineGen)