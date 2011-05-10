(function() {
  var Bean, coffee_draw;
  coffee_draw = function(p5) {
    p5.setup = function() {
      p5.size($(window).width(), $(window).height());
      p5.background(0);
      return this.beans = [];
    };
    p5.draw = function() {
      var bean, x, x_off, y, y_off, _i, _len, _ref, _results;
      p5.fade();
      x_off = p5.frameCount * 0.0003;
      y_off = x_off + 20;
      x = p5.noise(x_off) * p5.width;
      y = p5.noise(y_off) * p5.height;
      if (p5.frameCount % 8 === 0) {
        bean = new Bean(p5, {
          x: x,
          y: y,
          x_off: x_off,
          y_off: y_off
        });
        this.beans.push(bean);
      }
      _ref = this.beans;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        bean = _ref[_i];
        _results.push(bean.draw());
      }
      return _results;
    };
    return p5.fade = function() {
      if (p5.frameCount % 220 === 0) {
        p5.stroke(0, 0);
        p5.fill(0, 10);
        return p5.rect(0, 0, p5.width, p5.height);
      }
    };
  };
  Bean = (function() {
    function Bean(p5, opts) {
      this.p5 = p5;
      this.x = opts.x;
      this.y = opts.y;
      this.x_off = opts.x_off;
      this.y_off = opts.y_off;
      this.vel = opts.vel || 3;
      this.accel = opts.accel || -0.003;
    }
    Bean.prototype.draw = function() {
      if (!(this.vel > 0)) {
        return;
      }
      this.x_off += 0.0007;
      this.y_off += 0.0007;
      this.vel += this.accel;
      this.x += this.p5.noise(this.x_off) * this.vel - this.vel / 2;
      this.y += this.p5.noise(this.y_off) * this.vel - this.vel / 2;
      this.set_color();
      return this.p5.point(this.x, this.y);
    };
    Bean.prototype.set_color = function() {
      var a, b, h, s;
      this.p5.colorMode(this.p5.HSB, 360, 100, 100);
      h = this.p5.noise((this.x_off + this.y_off) / 2) * 360;
      s = 100;
      b = 100;
      a = 4;
      return this.p5.stroke(h, s, b, a);
    };
    return Bean;
  })();
  $(document).ready(function() {
    var canvas, processing;
    canvas = document.getElementById("processing");
    return processing = new Processing(canvas, coffee_draw);
  });
}).call(this);
