canvasHelper = module.exports =
  ellipse: (ctx, cx, cy, w, h) ->
    canvasHelper.drawEllipse ctx, cx - w / 2.0, cy - h / 2.0, w, h

  drawEllipse: (ctx, x, y, w, h) ->
    kappa = .5522848
    ox = (w / 2) * kappa # control point offset horizontal
    oy = (h / 2) * kappa # control point offset vertical
    xe = x + w # x-end
    ye = y + h # y-end
    xm = x + w / 2 # x-middle
    ym = y + h / 2 # y-middle

    ctx.beginPath()
    ctx.moveTo x, ym
    ctx.bezierCurveTo x, ym - oy, xm - ox, y, xm, y
    ctx.bezierCurveTo xm + ox, y, xe, ym - oy, xe, ym
    ctx.bezierCurveTo xe, ym + oy, xm + ox, ye, xm, ye
    ctx.bezierCurveTo xm - ox, ye, x, ym + oy, x, ym
    ctx.fill()
    ctx.closePath()
    # ctx.stroke()