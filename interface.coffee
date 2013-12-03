bean = require 'bean'
template = require './interface.jade'

Interface = module.exports = (pend) ->
  @el = document.createElement 'div'
  @el.classList.add 'interface'

  @pend = pend
  @setEvents()
  @render()

  return this


Interface::setEvents = ->
  events = [
    ['click', '.next', @nextStyle]
    ['click', '.prev', @prevStyle]
    ['click', '.state', @toggle]
  ]
    
  for event in events
    [type, selector, handler] = event
    bean.on @el, type, selector, handler.bind(this)

Interface::render = ->
  @el.innerHTML = template @pend

Interface::prevStyle = ->
  @pend.style -= 1
  @pend.style = 0 if @pend.style < 0

  @render()

Interface::nextStyle = ->
  @pend.style += 1
  @pend.style = 0 if @pend.style > 3

  @render()

Interface::toggle = ->
  @pend.toggle()
  @render()