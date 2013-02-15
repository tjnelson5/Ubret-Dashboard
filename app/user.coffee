class User extends Backbone.Events
  @current: null

  @apiUrl: =>
    if location.port > 1024 then "http://localhost:3000" else "https://spelunker.herokuapp.com"
    # "https://spelunker.herokuapp.com"

  @zooniverseUrl: =>
    if location.port > 4000 then "dev" else "api"

  @login: ({username, password}) =>
    url = "https://#{@zooniverseUrl()}.zooniverse.org/login?username=#{username}&password=#{password}&callback=?"
    login = $.getJSON(url)
    login.always @createUser
    login.success => User.trigger 'sign-in'
    login

  @logout: =>
    url = "https://#{@zooniverseUrl()}.zooniverse.org/logout?callback=?"
    logout = $.getJSON(url)
    logout.success =>
      User.current = null
      $.ajax "#{@apiUrl()}/users/logout",
        crossDomain: true
        xhrFields:
          withCredentials: true
        success: =>
          User.trigger 'sign-out'
    logout

  @currentUser: =>
    url = "https://#{@zooniverseUrl()}.zooniverse.org/current_user?callback=?"
    current = $.getJSON(url)
    current.always @createUser
    current.always (response) =>
      User.trigger 'sign-in' if User.current isnt null
    current

  @signup: ({username, password, email}) =>
    url = "https://#{@zooniverseUrl()}.zooniverse.org/signup?username=#{username}&password=#{password}&email=#{email}&callback=?"
    signup = $.getJSON(url)
    signup.always @createUser
    signup.success => User.trigger 'sign-in'
    signup

  @createUser: (response) =>
    User.current = if response.success
      delete response.success
      new User response
    else
      User.trigger 'sign-in-error', response.message
      null

  constructor: (options) ->
    _.extend @, Backbone.Events
    @name = options.name
    @id = options.id
    @apiToken = options.api_key
    @syncToSpelunker()

  syncToSpelunker: =>
    url = "#{User.apiUrl()}/users?zooniverse_id=#{@id}&name=#{@name}&api_token=#{@apiToken}"
    $.ajax 
      url: url
      type: 'GET'
      crossDomain: true
      contentType: 'application/json'
      dataType: 'json'
      cache: false
      xhrFields:
        withCredentials: true
      success: (response) =>
        @dashboards = new Backbone.Collection response.dashboards
        @trigger 'loaded-dashboards'

  removeDashboard: (id, cb) =>
    url = "#{User.apiUrl()}/dashboards/#{id}"
    $.ajax 
      url: url
      type: 'DELETE'
      crossDomain: true
      cache: false
      xhrFields:
        withCredentials: true
      success: (response) => cb response

module.exports = User