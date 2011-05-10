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
      p5.fade();
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
      p5.fill(0, 50);
      return p5.rect(0, 0, p5.width, p5.height);
    };
    return p5.mouseClicked = function() {
      return p5.balls.push(new Ball(p5, {
        o_x: p5.mouseX,
        o_y: p5.mouseY
      }));
    };
  };
  Ball = (function() {
    function Ball(p5, opts) {
      this.p5 = p5;
      this.o_x = opts.o_x;
      this.o_y = opts.o_y;
      this.r = 100;
      this.G = 0.4;
      this.theta = Math.PI / 2;
      this.ball_r = 20;
      this.vel = opts.vel || 0;
      this.accel = opts.accel || 0;
    }
    Ball.prototype.draw = function() {
      this.accel = (-1 * this.G / this.r) * Math.sin(this.theta);
      this.vel += this.accel;
      this.vel *= 0.999;
      this.theta += this.vel;
      this.b_x = this.o_x + (this.r * Math.sin(this.theta));
      this.b_y = this.o_y + (this.r * Math.cos(this.theta));
      this.p5.fill(255);
      return this.p5.ellipse(this.b_x, this.o_y, this.ball_r, this.ball_r);
    };
    return Ball;
  })();
  $(document).ready(function() {
    var canvas, processing;
    canvas = document.getElementById("processing");
    return processing = new Processing(canvas, coffee_draw);
  });
}).call(this);
