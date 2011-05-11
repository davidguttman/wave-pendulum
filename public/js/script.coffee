coffee_draw = (p5) ->
  p5.setup = ->
    p5.size $(window).width(), $(window).height()
    p5.background 0
    p5.n_balls = 24
    p5.reset_balls()
    p5.frameRate(60)
    
  p5.draw = ->
    p5.fade()
    for ball in p5.balls
      do (ball) =>
        ball.draw()

  p5.fade = ->
    p5.stroke(0, 0)
    p5.fill(0, 80)
    p5.rect(0, 0, p5.width, p5.height)
  
  p5.mouseClicked = ->
    p5.reset_balls()
    # p5.balls.push new Ball p5, 
    #   o_x: p5.mouseX
    #   o_y: p5.mouseY
      
  p5.reset_balls = ->
    p5.balls = []
    space = p5.height/(p5.n_balls*1)
    l = p5.width/3
    for num in [1..p5.n_balls]
      do (num) =>
        p5.balls.push new Ball p5,
          o_x: p5.width/2
          o_y: space * num - (space/2)
          b_x: l
          r: l * Math.pow((16/(16+(num-1))),2)

class Ball
  constructor: (@p5, opts) ->
    @o_x = opts.o_x
    @o_y = opts.o_y

    @b_x = opts.b_x

    @r = opts.r || 100
    @G = 0.14    
    @theta = Math.PI/2
    
    # (@b_x - @o_x)/@r = Math.sin(@theta)
    
    @ball_r = 12
        
    @vel = opts.vel || 0
    @accel = opts.accel || 0
  
  draw: ->  
    @accel = (-1 * @G / @r) * Math.sin(@theta)
    @vel += @accel
    @vel *= 1
    @theta += @vel
    
    @x_off = (@r * Math.sin(@theta))
    @y_off = (@r * Math.cos(@theta))
    
    @b_x = @o_x + @x_off
    @b_y = @o_y + @y_off
    
    bright = 255 - ((@b_y - @o_y)/@r * 128)
    
    x = (@x_off/@r)*@p5.height/4 + @o_x
    
    @p5.fill(255)
    @p5.ellipse(x, @o_y, @ball_r, @ball_r)

$(document).ready ->
  canvas = document.getElementById "processing"
  processing = new Processing(canvas, coffee_draw)