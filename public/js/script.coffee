coffee_draw = (p5) ->
  p5.setup = ->
    p5.size $(window).width(), $(window).height()
    p5.background 0
    p5.balls = []
    
  p5.draw = ->
    p5.fade()
    for ball in p5.balls
      do (ball) =>
        ball.draw()

  p5.fade = ->
    p5.stroke(0, 0)
    p5.fill(0, 50)
    p5.rect(0, 0, p5.width, p5.height)
  
  p5.mouseClicked = ->
    p5.balls.push new Ball p5, 
      o_x: p5.mouseX
      o_y: p5.mouseY

class Ball
  constructor: (@p5, opts) ->
    @o_x = opts.o_x
    @o_y = opts.o_y

    @r = 100
    @G = 0.4    
    @theta = Math.PI/2
    
    @ball_r = 20
        
    @vel = opts.vel || 0
    @accel = opts.accel || 0
  
  draw: ->  
    @accel = (-1 * @G / @r) * Math.sin(@theta)
    @vel += @accel
    @vel *= 0.999
    @theta += @vel
    
    @b_x = @o_x + (@r * Math.sin(@theta))
    @b_y = @o_y + (@r * Math.cos(@theta))
    
    @p5.fill(255)
    @p5.ellipse(@b_x, @o_y, @ball_r, @ball_r)

$(document).ready ->
  canvas = document.getElementById "processing"
  processing = new Processing(canvas, coffee_draw)