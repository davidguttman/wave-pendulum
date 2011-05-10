coffee_draw = (p5) ->
  p5.setup = ->
    p5.size $(window).width(), $(window).height()
    p5.background 0
    p5.balls = []
    
  p5.draw = ->
    # p5.fade()
    for ball in p5.balls
      do (ball) =>
        ball.draw()

  p5.fade = ->
    p5.stroke(0, 0)
    p5.fill(0, 10)
    p5.rect(0, 0, p5.width, p5.height)
  
  p5.mouseClicked = ->
    p5.balls.push(new Ball p5, x: p5.mouseX, y: p5.mouseY)
    # p5.fill(255)
    # p5.ellipse(p5.mouseX, p5.mouseY, 20, 20)

class Ball
  constructor: (@p5, opts) ->
    @x = opts.x
    @y = opts.y
    
    @w = 20
    @h = 20
        
    @vel = opts.vel || 0.1
    @accel = opts.accel || 0.0001
  
  draw: ->  
    @vel += @accel
    
    # @x += @vel
    @y += @vel
    
    @p5.fill(255)
    @p5.rect(@x, @y, @w, @h)

$(document).ready ->
  canvas = document.getElementById "processing"
  processing = new Processing(canvas, coffee_draw)