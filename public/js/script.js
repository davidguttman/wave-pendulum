(function() {
  var Ball, coffee_draw;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  coffee_draw = function(p5) {
    p5.setup = function() {
      p5.size($(window).width(), $(window).height());
      p5.background(0);
      return p5.balls = [];
    };
    p5.draw = function() {
      var ball, _i, _len, _ref, _results;
      _ref = p5.balls;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        ball = _ref[_i];
        _results.push(__bind(function(ball) {
          return ball.draw();
        }, this)(ball));
      }
      return _results;
    };
    p5.fade = function() {
      p5.stroke(0, 0);
      p5.fill(0, 10);
      return p5.rect(0, 0, p5.width, p5.height);
    };
    return p5.mouseClicked = function() {
      return p5.balls.push(new Ball(p5, {
        x: p5.mouseX,
        y: p5.mouseY
      }));
    };
  };
  Ball = (function() {
    function Ball(p5, opts) {
      this.p5 = p5;
      this.x = opts.x;
      this.y = opts.y;
      this.w = 20;
      this.h = 20;
      this.vel = opts.vel || 0.1;
      this.accel = opts.accel || 0.0001;
    }
    Ball.prototype.draw = function() {
      this.vel += this.accel;
      this.y += this.vel;
      this.p5.fill(255);
      return this.p5.rect(this.x, this.y, this.w, this.h);
    };
    return Ball;
  })();
  $(document).ready(function() {
    var canvas, processing;
    canvas = document.getElementById("processing");
    return processing = new Processing(canvas, coffee_draw);
  });
}).call(this);
