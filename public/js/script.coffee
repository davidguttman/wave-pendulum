soundManager.url = '/swf/'

CLICK_COUNT = 0

coffee_draw = (p5) ->
  p5.setup = ->
    p5.size $(window).width(), $(window).height()
    p5.background 0
    p5.n_balls = 16
    p5.reset_balls()
    p5.frameRate(60)
    p5.create_sounds()
    
  p5.draw = ->
    p5.fade()
    for ball in p5.balls
      do (ball) =>
        ball.draw()

  p5.create_sounds = ->
    for num in [1..(p5.n_balls-1)]
      do (num) ->
        console.log 'tone'+num
        soundManager.createSound({
         id:'tone'+num,
         url:'/mp3/twitternotes-'+(num)+'.mp3'
        })

  p5.fade = ->
    p5.stroke(0, 0)
    p5.fill(0, 90)
    p5.rect(0, 0, p5.width, p5.height)
  
  p5.mouseClicked = ->
    CLICK_COUNT += 1
    # p5.reset_balls()
    # p5.balls.push new Ball p5, 
    #   o_x: p5.mouseX
    #   o_y: p5.mouseY
      
  p5.reset_balls = ->
    p5.balls = []
    l = p5.width/3
    space = (p5.height-l/2)/(p5.n_balls)
    for num in [1..p5.n_balls]
      do (num) =>
        p5.balls.push new Ball p5,
          ball_id: num-1
          o_x: p5.width/2
          o_y: space * num - (space)
          b_x: l
          r: l * Math.pow((16/(16+(num-1))),2)

class Ball
  constructor: (@p5, opts) ->
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
  
  draw: ->  
    @accel = (-1 * @G / @r) * Math.sin(@theta)
    @vel += @accel
    @vel *= 1
    @theta += @vel
    
    @x_off = (@r * Math.sin(@theta))
    @y_off = (@r * Math.cos(@theta))
    
    @b_x = @o_x + @x_off
    @b_y = @o_y + @y_off
    
    @x_ratio = @x_off/@r
    @y_ratio = @y_off/@r
    
    @scaled_x = @x_ratio * (@p5.height/4) + @o_x
    @scaled_y = @y_ratio * (@p5.height/4) + @o_y
    
    if @x_ratio <= 0.025 and @x_ratio >= -0.025
      soundManager.play('tone'+(@ball_id))
      console.log 'sound_played'
      @active = true
    else
      @active = false
    
    style = CLICK_COUNT % 4
    
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
      @p5.fill 10
      @p5.stroke 100
      @p5.strokeWeight 10
      br = @ball_r*4
      @p5.ellipse(@o_x, y, br, br)
    else
      br = @ball_r
    
    @p5.noStroke()
    @p5.fill(255)
    @p5.ellipse(x, y, @ball_r, @ball_r)

soundManager.onready ->  
  canvas = document.getElementById "processing"
  processing = new Processing(canvas, coffee_draw)