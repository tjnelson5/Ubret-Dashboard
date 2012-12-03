AppView = require 'app_view'
User = require 'user'

class Router extends Backbone.Router
  routes:
    ''              : 'index'
    'dashboard/new' : 'newDashboard'
    'dashboard/:id' : 'retrieveDashboard'

  initialize: ->
    @appView = new AppView

  index: =>
    $('.dashboard').html require('views/templates/index')()

  retrieveDashboard: (id) =>
    @navigate("", {trigger: true}) if User.current is null
    @appView.createDashboard(id)

  newDashboard: =>
    @navigate("", {trigger: true}) if User.current is null
    @appView.createDashboard()


module.exports = Router
