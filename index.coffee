require './bootstrap.coffee'
require './style.scss'

Pendulum = require './pendulum.coffee'
Interface = require './interface.coffee'

template = require './template.jade'

w = window.innerWidth
h = window.innerHeight
pendulum = new Pendulum w, h
document.body.appendChild pendulum.el

iface = new Interface pendulum
document.body.appendChild iface.el