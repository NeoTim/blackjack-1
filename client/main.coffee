# new AppView(model: new App()).$el.appendTo 'body'

window.appView = new AppView
  model: new App

appView.$el.appendTo ".container"


window.restart = ->
  appView.$el.remove()
  delete window.appView

  window.appView = new AppView
    model: new App

  appView.$el.appendTo ".container"
