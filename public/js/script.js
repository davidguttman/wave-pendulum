(function() {
  var Ball, CLICK_COUNT, coffee_draw;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  soundManager.url = '/swf/';
  soundManager.defaultOptions = {
    multiShot: false
  };
  CLICK_COUNT = 0;
  coffee_draw = function(p5) {
    p5.setup = function() {
      p5.size($(window).width(), $(window).height());
      p5.background(0);
      p5.n_balls = 16;
      p5.reset_balls();
      p5.frameRate(60);
      return p5.create_sounds();
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
    p5.create_sounds = function() {
      var num, _ref, _results;
      _results = [];
      for (num = 1, _ref = p5.n_balls - 1; 1 <= _ref ? num <= _ref : num >= _ref; 1 <= _ref ? num++ : num--) {
        _results.push((function(num) {
          console.log('tone' + num);
          return soundManager.createSound({
            id: 'tone' + num,
            url: '/mp3/twitternotes-' + num + '.mp3'
          });
        })(num));
      }
      return _results;
    };
    p5.fade = function() {
      p5.stroke(0, 0);
      p5.fill(0, 90);
      return p5.rect(0, 0, p5.width, p5.height);
    };
    p5.mouseClicked = function() {
      return CLICK_COUNT += 1;
    };
    return p5.reset_balls = function() {
      var l, num, space, _ref, _results;
      p5.balls = [];
      l = p5.width / 3;
      space = (p5.height - l / 2) / p5.n_balls;
      _results = [];
      for (num = 1, _ref = p5.n_balls; 1 <= _ref ? num <= _ref : num >= _ref; 1 <= _ref ? num++ : num--) {
        _results.push(__bind(function(num) {
          return p5.balls.push(new Ball(p5, {
            ball_id: num - 1,
            o_x: p5.width / 2,
            o_y: space * num - space,
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
      this.ball_id = opts.ball_id;
      this.o_x = opts.o_x;
      this.o_y = opts.o_y;
      this.b_x = opts.b_x;
      this.r = opts.r || 100;
      this.G = 0.2;
      this.theta = 0.8 * Math.PI / 2;
      this.ball_r = 12;
      this.vel = opts.vel || 0;
      this.accel = opts.accel || 0;
    }
    Ball.prototype.draw = function() {
      var br, style, x, y;
      this.accel = (-1 * this.G / this.r) * Math.sin(this.theta);
      this.vel += this.accel;
      this.vel *= 1;
      this.theta += this.vel;
      this.x_off = this.r * Math.sin(this.theta);
      this.y_off = this.r * Math.cos(this.theta);
      this.b_x = this.o_x + this.x_off;
      this.b_y = this.o_y + this.y_off;
      this.x_ratio = this.x_off / this.r;
      this.y_ratio = this.y_off / this.r;
      this.scaled_x = this.x_ratio * (this.p5.height / 4) + this.o_x;
      this.scaled_y = this.y_ratio * (this.p5.height / 4) + this.o_y;
      if (this.x_ratio <= 0.025 && this.x_ratio >= -0.025) {
        soundManager.play('tone' + this.ball_id);
        console.log('sound_played');
        this.active = true;
      } else {
        this.active = false;
      }
      style = CLICK_COUNT % 4;
      switch (style) {
        case 0:
          x = this.scaled_x;
          y = this.scaled_y;
          break;
        case 1:
          x = this.b_x;
          y = this.o_y + this.p5.height / 4;
          break;
        case 2:
          x = this.b_x;
          y = this.scaled_y;
          break;
        case 3:
          x = this.b_x;
          y = this.b_y;
      }
      if (this.active) {
        this.p5.fill(10);
        this.p5.stroke(100);
        this.p5.strokeWeight(10);
        br = this.ball_r * 4;
        this.p5.ellipse(this.o_x, y, br, br);
      } else {
        br = this.ball_r;
      }
      this.p5.noStroke();
      this.p5.fill(255);
      return this.p5.ellipse(x, y, this.ball_r, this.ball_r);
    };
    return Ball;
  })();
  soundManager.onready(function() {
    var canvas, processing;
    canvas = document.getElementById("processing");
    return processing = new Processing(canvas, coffee_draw);
  });
}).call(this);
