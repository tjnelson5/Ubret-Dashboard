class DataSource extends Backbone.AssociatedModel
  sync: require 'sync' 

  relations: [
    type: Backbone.Many
    key: 'params'
    relatedModel: require 'models/param'
    collectionType: require 'collections/params'
  ]

  defaults:
    params: []

  manager: require 'modules/manager'
  subjects: require 'collections/subjects'

  urlRoot: =>
    "/dashboards/#{@manager.get('dashboardId')}/tools/#{@get('toolId')}/data_sources"

  # toJSON: ->
  #   json = new Object
  #   json[key] = value for key, value of @attributes when key isnt ('tools' or 'params')
  #   json['params'] = @get('params').toJSON()
  #   return json

  fetchData: =>
    if @isExternal()
      @fetchExt()
    else if @isInternal()
      @fetchInt()
    else
      throw 'unknown source type'

  fetchExt: =>
    url = @manager.get('sources').get(@get('source')).get('url')
    @data = new @subjects([], {params: @get('params'), url: url })
    @data.fetch
      success: =>
        @save()
      error: =>
        console.log 'error fetching subjects'

  fetchInt: =>
    if not _.isUndefined @source
      @data = []
      @save()

  isExternal: =>
    (@get('source_type') is 'external')

  isInternal: =>
    (@get('source_type') is 'internal')

  isReady: =>
    (@isInternal() and (not _.isUndefined(@source))) or (@isExternal() and (not _.isUndefined(@data)))

  sourceName: =>
    if @isExternal()
      name = @manager.get('sources').get(@get('source')).get('name')
    else if @isInternal()
      name = @source.get('name')
    else
      name = ''
    return name

module.exports = DataSource