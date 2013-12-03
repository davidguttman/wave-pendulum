canvasHelper = require './canvas-helper.coffee'

CLICK_COUNT = 0
PRESS_COUNT = 0

Pendulum = module.exports = (w, h) ->
  @el = document.createElement 'div'
  @el.classList.add 'pendulum'

  @canvas = document.createElement 'canvas'
  @el.appendChild @canvas

  [@width, @height] = [w, h]

  @canvas.width = @width
  @canvas.height = @height

  @ctx = @canvas.getContext '2d'

  @fade 1
  @nBalls = 16
  @resetBalls()

  @drawLoop()

  return this
  
Pendulum::draw = ->
  @fade()
  for ball in @balls
    ball.draw()

Pendulum::fade = (a=0.5) ->
  @ctx.fillStyle = toRgba 0, 0, 0, a
  @ctx.lineWidth = 0
  @ctx.fillRect 0, 0, @width, @height
    
Pendulum::resetBalls = ->
  @balls = []
  l = @width/3
  space = (@height-l/2)/(@nBalls)
  for num in [1..@nBalls]
    do (num) =>
      @balls.push new Ball this,
        ball_id: num-1
        o_x: @width/2
        o_y: space * num - (space)
        b_x: l
        r: l * Math.pow((@nBalls/(@nBalls+(num-1))),2)

Pendulum::drawLoop = ->
  window.requestAnimationFrame @drawLoop.bind(this)
  # setTimeout @drawLoop.bind(this), 250
  @draw()

class Ball
  constructor: (@p5, opts) ->
    @ctx = @p5.ctx

    @ball_id = opts.ball_id
    
    @o_x = opts.o_x
    @o_y = opts.o_y

    @b_x = opts.b_x

    @r = opts.r || 100
    @G = 0.2
    @theta = 0.8*Math.PI/2
    
    # (@b_x - @o_x)/@r = Math.sin(@theta)
    
    @ball_r = 12
        
    @vel = opts.vel || 0
    @accel = opts.accel || 0

  update: ->
    @accel = (-1 * @G / @r) * Math.sin(@theta)
    @vel += @accel
    @theta += @vel
    
    @x_off = (@r * Math.sin(@theta))
    @y_off = (@r * Math.cos(@theta))
    
    @b_x = @o_x + @x_off
    @b_y = @o_y + @y_off
    
    @x_ratio = @x_off/@r
    @y_ratio = @y_off/@r
    
    @scaled_x = @x_ratio * (@p5.height/4) + @o_x
    @scaled_y = @y_ratio * (@p5.height/4) + @o_y

  draw: ->  
    @update()
    
    if @x_ratio <= 0.025 and @x_ratio >= -0.025
      # soundManager.play('tone'+(@ball_id))
      # console.log 'sound_played'
      # @active = true
    else
      @active = false
    
    style = CLICK_COUNT % 4
    colors = PRESS_COUNT % 2
    
    switch style
      when 0
        x = @scaled_x
        y = @scaled_y
      when 1
        x = @b_x
        y = @o_y + @p5.height/4
      when 2
        x = @b_x
        y = @scaled_y
      when 3
        x = @b_x
        y = @b_y
    
    if @active
      @ctx.fillStyle = toRgba 10, 10, 10
      @ctx.strokeStyle = toRgba 100, 100, 100
      @ctx.lineWidth = 10
      br = @ball_r * 4
      # @p5.ellipse(@o_x, y, br, br)
    else
      br = @ball_r
    
    @ctx.lineWidth = 0
    @ctx.fillStyle = toRgba 255, 255, 255
    canvasHelper.ellipse @ctx, x, y, @ball_r, @ball_r

    # canvasHelper.ellipse @ctx, 10, 10, 10, 10

toRgba = (colors...) ->
  rgb = colors[0..2].map (c) -> Math.round c
  rgb.push (colors[3] or 1)

  str = "rgba(#{rgb.join ','})"

  return str