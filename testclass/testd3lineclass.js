// Generated by CoffeeScript 1.9.1
(function() {
  var render;

  describe("TEST D3line class", function() {
    describe('set data', function() {
      beforeEach(function() {
        render();
        this.visualisation = document.querySelector('.d3linesvg');
        return this.d3line = new D3Line(this.visualisation);
      });
      return it("width is set with right data", function() {
        var result;
        result = this.d3line.width;
        return assert(result === 500 * 0.8);
      });
    });
    return describe('draw', function() {
      beforeEach(function() {
        render();
        this.visualisation = document.querySelector('.d3linesvg');
        return this.d3line = new D3Line(this.visualisation);
      });
      return it('draw called once', function() {});
    });
  });

  render = function() {
    var svg;
    return svg = d3.select('body').append('svg').attr('class', 'd3linesvg').attr('height', '500').attr('width', '500');
  };

}).call(this);

//# sourceMappingURL=testd3lineclass.js.map