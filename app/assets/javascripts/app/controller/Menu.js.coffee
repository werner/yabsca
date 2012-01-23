Ext.define 'YABSCA.controller.Menu',
  extend: 'Ext.app.Controller'
  stores: ['Units', 'Responsibles']
  models: ['Unit', 'Responsible']
  views: ['unit.Window', 'unit.Grid', 'unit.Form',
          'responsible.Window', 'responsible.Grid', 'responsible.Form']
  init: ->
    @control(
      'viewport component[action=units]':
        click: @showUnitGrid
      'viewport component[action=responsibles]':
        click: @showResponsibleGrid
    )
  showUnitGrid: ->
    window = Ext.create 'YABSCA.view.unit.Window'
    window.show()
  showResponsibleGrid: ->
    window = Ext.create 'YABSCA.view.responsible.Window'
    window.show()
