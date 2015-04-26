class @D3Line
  constructor: (@visualisation) ->
    this.width = this.visualisation.clientWidth*0.8
  draw: ->
    this.drawline()

