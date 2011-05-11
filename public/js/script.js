(function() {
  var Ball, coffee_draw;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  coffee_draw = function(p5) {
    p5.setup = function() {
      p5.size($(window).width(), $(window).height());
      p5.background(0);
      p5.n_balls = 24;
      p5.reset_balls();
      return p5.frameRate(60);
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
      p5.fill(0, 20);
      return p5.rect(0, 0, p5.width, p5.height);
    };
    p5.mouseClicked = function() {
      return p5.reset_balls();
    };
    return p5.reset_balls = function() {
      var l, num, space, _ref, _results;
      p5.balls = [];
      space = p5.height / (p5.n_balls * 1);
      l = p5.width / 3;
      _results = [];
      for (num = 1, _ref = p5.n_balls; 1 <= _ref ? num <= _ref : num >= _ref; 1 <= _ref ? num++ : num--) {
        _results.push(__bind(function(num) {
          return p5.balls.push(new Ball(p5, {
            o_x: p5.width / 2,
            o_y: space * num - (space / 2),
            b_x: l,
            r: l * Math.pow(16 / (16 + (num - 1)), 2)
          }));
        }, this)(num));
      }
      return _results;
    };
  };
  Ball = (function() {
    function Ball(p5, opts) {
      this.p5 = p5;
      this.o_x = opts.o_x;
      this.o_y = opts.o_y;
      this.b_x = opts.b_x;
      this.r = opts.r || 100;
      this.G = 0.14;
      this.theta = Math.PI / 2;
      this.ball_r = 12;
      this.vel = opts.vel || 0;
      this.accel = opts.accel || 0;
    }
    Ball.prototype.draw = function() {
      var bright, x;
      this.accel = (-1 * this.G / this.r) * Math.sin(this.theta);
      this.vel += this.accel;
      this.vel *= 1;
      this.theta += this.vel;
      this.x_off = this.r * Math.sin(this.theta);
      this.y_off = this.r * Math.cos(this.theta);
      this.b_x = this.o_x + this.x_off;
      this.b_y = this.o_y + this.y_off;
      bright = 255 - ((this.b_y - this.o_y) / this.r * 128);
      x = (this.x_off / this.r) * this.p5.height / 4 + this.o_x;
      this.p5.fill(255);
      return this.p5.ellipse(x, this.o_y, this.ball_r, this.ball_r);
    };
    return Ball;
  })();
  $(document).ready(function() {
    var canvas, processing;
    canvas = document.getElementById("processing");
    return processing = new Processing(canvas, coffee_draw);
  });
}).call(this);
