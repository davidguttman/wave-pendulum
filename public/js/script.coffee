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
    p5.fill(0, 90)
    p5.rect(0, 0, p5.width, p5.height)
  
  p5.mouseClicked = ->
    p5.reset_balls()
    # p5.balls.push new Ball p5, 
    #   o_x: p5.mouseX
    #   o_y: p5.mouseY
      
  p5.reset_balls = ->
    p5.balls = []
    l = p5.width/3
    space = p5.height/(p5.n_balls+1)
    for num in [1..p5.n_balls]
      do (num) =>
        p5.balls.push new Ball p5,
          o_x: p5.width/2
          o_y: 20
          b_x: l
          r: space * num

class Ball
  constructor: (@p5, opts) ->
    @o_x = opts.o_x
    @o_y = opts.o_y

    @b_x = opts.b_x

    @r = opts.r || 100
    @G = 0.2
    @theta = 0.4*Math.PI/2
    
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
    
    x = @x_off + @o_x
    y = @y_off + @o_y
    
    @p5.fill(255)
    @p5.ellipse(x, y, @ball_r, @ball_r)

$(document).ready ->
  canvas = document.getElementById "processing"
  processing = new Processing(canvas, coffee_draw)
