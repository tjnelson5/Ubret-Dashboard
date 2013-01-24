BaseView = require 'views/base_view'

class KeySettings extends BaseView
  tagName: 'div'
  className: 'key-settings'
  template: require 'views/templates/key_settings'

  events:
    'change .select-key' : 'onSelectKey'

  initialize: ->
    Backbone.Mediator.subscribe("#{@model.get('channel')}:keys", @setKeys)

  render: =>
    @$el.html @template({ keys: @keys, currentKey: @model.get('selected_keys')[0] })
    @

  setKeys: (keys) =>
    @keys = keys
    @render()

  #Events
  onSelectKey: (e) =>
    @model.set 'selected_keys', [@$(e.currentTarget).val()]

module.exports = KeySettings