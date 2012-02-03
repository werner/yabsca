Ext.define 'YABSCA.controller.Menu',
  extend: 'Ext.app.Controller'
  stores: ['Units', 'Responsibles']
  models: ['Unit', 'Responsible']
  views: ['unit.Window', 'unit.Grid', 'unit.Form',
          'responsible.Window', 'responsible.Grid', 'responsible.Form',
          'user.Window', 'user.Form', 'user.Grid']
  init: ->
    @control(
      'viewport component[action=units]':
        click: @showUnitGrid
      'viewport component[action=responsibles]':
        click: @showResponsibleGrid
      'viewport component[action=users]':
        click: @showUserGrid
    )
  showUnitGrid: ->
    window = Ext.create 'YABSCA.view.unit.Window'
    window.show()
  showResponsibleGrid: ->
    window = Ext.create 'YABSCA.view.responsible.Window'
    window.show()
  showUserGrid: ->
    window = Ext.create 'YABSCA.view.user.Window'
    window.show()
