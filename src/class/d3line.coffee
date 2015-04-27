class @D3Line
  constructor: (@svgElement, @data1, @data2) ->
    this.dataset1 = this.data1
    this.dataset2 = this.data2
    this.width = this.svgElement.clientWidth
    this.height = this.svgElement.clientHeight
    this.visualization = d3.select(this.svgElement)
    this.margins = {
      top:20,
      right: 20,
      bottom: 20,
      left: 50
    }

  draw: ->
    this._set_scale()
    this._set_axis()
    linedata1 = this._getLineData1()
    linedata2 = this._getLineData2()
    this._draw_line(linedata1, linedata2)
    this._animatePath()


  _set_scale: ->
    this.xScale = d3.scale.linear().range([this.margins.left, this.width - this.margins.right]).domain([2000,2010])
    this.yScale = d3.scale.linear().range([this.height - this.margins.bottom, this.margins.top]).domain([134,215])

  _set_axis: ->
    this.xaxis = this.visualization.append("svg:g")
      .attr("class","x axis")
      .attr("transform", "translate(0," + (this.height - this.margins.bottom) + ")")
    this.yaxis = this.visualization.append("svg:g")
      .attr("class","y axis")
      .attr("transform", "translate(" + (this.margins.left) + ",0)")
    this._set_axis_scale()
    this._call_axis()

  _set_axis_scale: ->
    this.xAxis = d3.svg.axis().scale(this.xScale)
    this.yAxis = d3.svg.axis()
                    .scale(this.yScale)
                    .orient("left")
  _call_axis: ->
    this.xaxis.call(this.xAxis)
    this.yaxis.call(this.yAxis)

  _setresponsive: ->
    this._set_scale()
    this._set_axis_scale()
    this._call_axis()
    linedata1 = this._getLineData1()
    linedata2 = this._getLineData2()
    this._updataLineData(linedata1, linedata2)
    this._updateAnimate()

  _updataLineData: (linedata1, linedata2)->
    this.dataset1line.attr('d', linedata1)
    this.dataset2line.attr('d', linedata2)

  _draw_line: (line1data, line2data)->
    this.dataset1line = this.visualization.append('svg:path')
      .attr('stroke', 'green')
      .attr('stroke-width', 2)
      .attr('fill', 'none')
      .attr('d', line1data)
    this.dataset2line = this.visualization.append('svg:path')
      .attr('stroke', 'blue')
      .attr('stroke-width', 2)
      .attr('fill', 'none')
      .attr('d', line2data)

  _genLine: ->
    _this = this
    d3.svg.line()
      .x((d) ->
        _this.xScale(d.year))
      .y((d) ->
        _this.yScale(d.sale))

  _getLineData1: ->
    genLine = this._genLine()
    genLine(this.dataset1)

  _getLineData2: ->
    genLine = this._genLine()
    genLine(this.dataset2)

  _getLine1TotalLength: ->
    this.dataset1line.node().getTotalLength()

  _getLine2TotalLength: ->
    this.dataset1line.node().getTotalLength()

  _animatePath: ->
    this.totalLength1 = this._getLine1TotalLength()
    this.totalLength2 = this._getLine2TotalLength()
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

  _updateAnimate: ->
    this.dataset1line
      .attr("stroke-dasharray", 0)
      .attr("stroke-dashoffset", 0)
    this.dataset2line
      .attr("stroke-dasharray", 0)
      .attr("stroke-dashoffset", 0)

