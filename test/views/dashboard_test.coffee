Dashboard = require 'views/dashboard'
DashboardModel = require 'models/dashboard'
ToolWindow = require 'views/tool_window'

describe 'Dashboard View', ->
  beforeEach ->
    @dashboardView = new Dashboard
      model: new DashboardModel {tools: [{id: 1, tool_type: "Table"}, {tool_type: "History"}]}

  it 'should be instantiable', ->
    expect(@dashboardView).to.be.defined

  it 'should have a toolbox', ->
    expect(@dashboardView).to.have.property('toolboxView')
      .and.be.an.instanceof(require('views/toolbox'))

  describe '#render', ->
    beforeEach ->
      @addToolSpy = sinon.stub(@dashboardView, 'addTool')

    afterEach ->
      @addToolSpy.restore()

    it 'should render the template', ->
      tempSpy = sinon.spy(@dashboardView, 'template')
      htmlSpy = sinon.spy(@dashboardView.$el, 'html')
      @dashboardView.render()
      expect(tempSpy).to.have.been.called
      expect(htmlSpy).to.have.been.called

    it 'should assign the toolbox', ->
      assignSpy = sinon.spy(@dashboardView, 'assign')
      @dashboardView.render()
      expect(assignSpy).to.have.been.calledWith('.toolbox', @dashboardView.toolboxView)

    it 'should render all the tools', ->
      @dashboardView.render()
      expect(@addToolSpy).to.have.been.calledTwice

  describe '#focusWindow', ->
    it 'should call focus with the tool that was clicked on', ->
      focusSpy = sinon.spy(@dashboardView.model.get('tools'), 'focus')
      @dashboardView.focusWindow({currentTarget: {dataset: {id: 1}}})
      expect(focusSpy).to.have.been
        .calledWith(@dashboardView.model.get('tools').get(1))

  describe '#addToolModel', ->
    it 'should call createTool', ->
      createSpy = sinon.spy(@dashboardView.model, 'createTool')
      @dashboardView.addToolModel 'Table'
      expect(createSpy).to.have.been.calledWith("Table")

  describe '#addTool', ->
    it 'create a tool window and render it', ->
      toolWindow = sinon.mock({render: -> console.log "this shouldn't be called"})
        .expects("render").returns { el: 'something' }
      toolWindowConstructor = sinon.stub(@dashboardView, 'toolWindow').returns(toolWindow)
      appendSpy = sinon.spy(@dashboardView.$el, 'append')
      @dashboardView.addTool {an: 'OBJECT!'}
      expect(appendSpy).to.have.been.calledWith({el: 'something'})

    
    
