User = require 'lib/user'
Manager = require 'modules/manager'

ouroborosSync = (method, model, options) ->
  baseURL = if isNaN(parseInt(location.port))
    "https://api.zooniverse.org" 
  else if parseInt(location.port) is 3333
    "http://192.168.33.10"
  else 
    "https://dev.zooniverse.org"
  options.url = baseURL + "/projects/#{Manager.get('project')}" + _.result(model, 'url')
  options.crossDomain = true
  if User.current?
    options.beforeSend = (xhr) ->
      xhr.setRequestHeader 'Authorization', "Basic #{btoa("#{User.current.name}:#{User.current.apiToken}")}"
  
  return Backbone.sync(method, model, options)

module.exports = ouroborosSync
