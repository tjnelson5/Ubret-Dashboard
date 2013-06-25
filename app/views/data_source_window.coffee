Window = require 'views/window'
ParamsView = require 'views/params'

class DataSourceWindow extends Window
  className: 'tool-window data-source-window'
  manager: require 'modules/manager'
  sourceTemplate: require './templates/data_source_window'

  events:
    'change select.search_types' : 'setSearchType'
    'click .load' : 'importData'

  initialize: ->
    super
    @paramsView = new ParamsView 
      collection: @model.get('data_source.params')
    @model.on 'change:data_source.search_type', @render

  setParams: =>
    if @model.get('data_source.search_type')?
      @model.get('data_source.params').reset()
      params = @searchTypes()[@model.get('data_source.search_type')].params
      for key, value of params
        @model.get('data_source.params').add _.extend({key: key}, value) 

  setSearchType: =>
    search = @$('select.search_types option:selected').val()
    @model.updateFunc('data_source.search_type', search)
    @setParams()

  render: =>
    super
    @paramsView.collection = @model.get('data_source.params')
    @$('.container').html @sourceTemplate
      source: @model.get('tool_type')
      search_type: @model.get('data_source.search_type')
      search_types: @searchTypes()
    @assign
      '.params' : @paramsView
    @$('.settings').remove()
    @

  searchTypes: =>
    @manager.get('sources')
      .get(@model.get('data_source.source_id')).search_types

  importData: =>
    @model.updateFunc 'data_source.params', @paramsView.setState()
    @model.updateData(true)


module.exports = DataSourceWindow