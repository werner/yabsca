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
        click: @deleteTarget
      'target_form button[action=back]':
        click: YABSCA.lib.StandardActions.backToGrid
      'target_form button[action=save]':
        click: @saveTarget
      'target_grid button[action=calculate]':
        click: @calculateTargets
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
  saveTarget: (button) ->
    lib = @loadStore()
    lib.saveRecord button, lib.callback
  deleteTarget: (button) ->
    lib = @loadStore()
    lib.deleteRecord button, lib.callback
  loadStore: ->
    me = this
    selected_node = Ext.ComponentQuery.query('measure_tree')[0].getSelectionModel().getSelection()[0]
    if selected_node?
      callback = ->
        me.getTargetsStore().load
          params:
            measure_id: selected_node.raw.iddb
      lib = YABSCA.lib.StandardActions
      lib.mainModel = me.mainModel
      lib.mainPanel = me.mainPanel
      lib.mainStore = me.mainStore
      lib.callback = callback
      lib
  calculateTargets: (button) ->
    me = this
    selected_node = Ext.ComponentQuery.query('measure_tree')[0].getSelectionModel().getSelection()[0]
    if selected_node?
      Ext.Ajax.request
        url: '/calculates_all'
        method: 'POST'
        params:
          measure_id: selected_node.raw.iddb
      me.getTargetsStore().load
        params:
          measure_id: selected_node.raw.iddb
