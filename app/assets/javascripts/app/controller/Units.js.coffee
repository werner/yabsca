Ext.define 'YABSCA.controller.Units',
  extend: 'Ext.app.Controller'
  stores: ['Units']
  models: ['Unit']
  views: ['unit.Form', 'unit.Grid']
  requires: ['YABSCA.lib.StandardActions']
  mainModel: 'YABSCA.model.Unit'
  mainStore: ->
    @getUnitsStore()
  init: ->
    @control(
      'unit_grid button[action=add]':
        click: YABSCA.lib.StandardActions.addRecord
      'unit_grid button[action=edit]':
        click: YABSCA.lib.StandardActions.editRecord
      'unit_grid button[action=delete]':
        click: YABSCA.lib.StandardActions.deleteRecord
      'unit_form button[action=back]':
        click: YABSCA.lib.StandardActions.backToGrid
      'unit_form button[action=save]':
        click: YABSCA.lib.StandardActions.saveRecord
    )
