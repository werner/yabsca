Ext.define 'YABSCA.controller.Responsibles',
  extend: 'Ext.app.Controller'
  stores: ['Responsibles']
  models: ['Responsible']
  views: ['responsible.Form', 'responsible.Grid']
  requires: ['YABSCA.lib.StandardActions']
  mainModel: 'YABSCA.model.Responsible'
  mainPanel: 'responsible_window'
  mainStore: ->
    @getResponsiblesStore()
  init: ->
    @control(
      'responsible_grid button[action=add]':
        click: YABSCA.lib.StandardActions.addRecord
      'responsible_grid button[action=edit]':
        click: YABSCA.lib.StandardActions.editRecord
      'responsible_grid button[action=delete]':
        click: YABSCA.lib.StandardActions.deleteRecord
      'responsible_form button[action=back]':
        click: YABSCA.lib.StandardActions.backToGrid
      'responsible_form button[action=save]':
        click: YABSCA.lib.StandardActions.saveRecord
    )
