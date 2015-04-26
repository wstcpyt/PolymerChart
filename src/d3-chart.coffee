polymer = {
  is: 'd3-chart'
  properties: {
    zerodata: {
      type: Array
      value: [{
        "sale": "0",
        "year": "0"
      }, {
        "sale": "0",
        "year": "0"
      }, {
        "sale": "0",
        "year": "0"
      }, {
        "sale": "0",
        "year": "0"
      }, {
        "sale": "0",
        "year": "0"
      },{
        "sale": "0",
        "year": "0"
      }]
    }
    data1: {
      type: Array
      value: [{
        "sale": "202",
        "year": "2000"
      }, {
        "sale": "215",
        "year": "2001"
      }, {
        "sale": "179",
        "year": "2002"
      }, {
        "sale": "199",
        "year": "2003"
      }, {
        "sale": "134",
        "year": "2004"
      },{
        "sale": "176",
        "year": "2010"
      }]
    }
    data2: {
      type: Array
      value: [{
        "sale": "152",
        "year": "2000"
      }, {
        "sale": "189",
        "year": "2002"
      }, {
        "sale": "179",
        "year": "2004"
      }, {
        "sale": "199",
        "year": "2006"
      }, {
        "sale": "134",
        "year": "2008"
      }, {
        "sale": "176",
        "year": "2010"
      }]
    }
  }
  ready: ->
    _this = this
    this.visualisation = this.$.visualisation
    window.addEventListener('WebComponentsReady', ->
      _this.d3line = new D3Line(_this.visualisation)
      _this.d3line.draw()
    )
}
Polymer(polymer)

