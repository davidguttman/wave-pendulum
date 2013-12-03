bean = require 'bean'
template = require './interface.jade'

Interface = module.exports = (segra) ->
  @el = document.createElement 'div'
  @el.classList.add 'interface'

  @segra = segra
  @setEvents()
  @render()

  return this


Interface::setEvents = ->
  events = [
    ['click', '.plus', @incSimReq]
    ['click', '.minus', @decSimReq]
    ['click', '.state', @toggle]
    ['click', '.randomize', @randomize]
  ]
    
  for event in events
    [type, selector, handler] = event
    bean.on @el, type, selector, handler.bind(this)

Interface::render = ->
  @el.innerHTML = template @segra

Interface::randomize = ->
  @segra.randomize()

Interface::decSimReq = ->
  @segra.simReq -= 1
  @segra.simReq = 0 if @segra.simReq < 0

  @render()

Interface::incSimReq = ->
  @segra.simReq += 1
  @segra.simReq = 0 if @segra.simReq >= 8

  @render()

Interface::toggle = ->
  @segra.toggle()
  @render()