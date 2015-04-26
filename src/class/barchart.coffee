class @barChart
  setData: (d)->
    this.data = d
    this.h = 500 - 80
    this.w = 500
  getData: ->
    this.data
  render: ->
    _this = this
    if this.data == undefined
      this.data = []
    svg = d3.select('body').append('svg')
             .attr('height', '500')
             .attr('width', '500')
            .append('g')
             .attr("transform", "translate('0, 0')")

    x = d3.scale.ordinal().rangeRoundBands([0, this.w], .05)
    x.domain(this.data.map((d) ->
      d.date
    ))
    y = d3.scale.linear().range([this.h, 0])
    y.domain([0, d3.max(this.data, (d)->
      d.value
    )])

    bars = svg.selectAll('.bar').data(this.getData())
    bars
        .enter().append('rect')
        .attr('class', 'bar')
        .attr('x', (d)->
          x(d.date)
        )
        .attr('width', x.rangeBand())
        .attr('y', (d)->
          y(d.value)
        )
        .attr('height', (d)->
          _this.h - y(d.value)
        )
