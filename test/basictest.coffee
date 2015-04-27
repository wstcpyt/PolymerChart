suite('basic', ->
  suite('ready', ->
    setup(->
      this.d3chart = fixture('basic')
    )
    test('ready set visualization', ->
      assert.notEqual(this.d3chart.visualization, undefined)
    )
    test('webcomponent ready event', ->
      event = new CustomEvent('WebComponentsReady')
      window.dispatchEvent(event)
      assert.notEqual(this.d3chart.d3line.width, undefined)
    )
    test('window on resize event', ->
      readyevent = new CustomEvent('WebComponentsReady')
      window.dispatchEvent(readyevent)
      resizeevent = new CustomEvent('resize')
      window.dispatchEvent(resizeevent)
      assert.notEqual(this.d3chart.d3line.width, undefined)
    )
  )
)