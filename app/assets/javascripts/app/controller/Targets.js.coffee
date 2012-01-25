Ext.define 'YABSCA.controller.Targets',
  extend: 'Ext.app.Controller'
  stores: ['Targets', 'Periods']
  models: ['Target', 'Period']
  views: ['target.Form', 'target.Grid', 'target.Panel']
  requires: ['YABSCA.lib.StandardActions']
  mainModel: 'YABSCA.model.Target'
  mainPanel: 'target_panel'
  mainStore: ->
    @getTargetsStore()
  init: ->
    @control(
      'target_grid button[action=add]':
        click: @addTarget
      'target_grid button[action=edit]':
        click: YABSCA.lib.StandardActions.editRecord
      'target_grid button[action=delete]':
        click: YABSCA.lib.StandardActions.deleteRecord
      'target_form button[action=back]':
        click: YABSCA.lib.StandardActions.backToGrid
      'target_form button[action=save]':
        click: YABSCA.lib.StandardActions.saveRecord
    )
  addTarget: (button) ->
    selected_node = Ext.ComponentQuery.query('measure_tree')[0].getSelectionModel().getSelection()[0]
    if selected_node?
      panel = button.up('target_panel')
      panel.down('form').getForm().reset()
      panel.getLayout().setActiveItem 1

      id = selected_node.raw.iddb
      panel.down('form').loadRecord
        data:
          measure_id: id
      panel.down('combo').allQuery = id
