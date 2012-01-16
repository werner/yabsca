Ext.define 'YABSCA.controller.Strategies',
  extend: 'Ext.app.Controller'
  stores: ['Organizations']
  models: ['Strategy']
  views: ['organization.Tree', 'organization.Menu', 'organization.Form']
  requires: ['YABSCA.lib.StandardActions']
  mainForm: 'YABSCA.view.strategy.Form'
  mainModel: 'YABSCA.model.Strategy'
  mainStore: ->
    @getOrganizationsStore()
  init: ->
    @control(
      'organization_menu component[action=new_strategy]':
        click: @addStrategy
      'organization_menu component[action=edit_strategy]':
        click: @editStrategy
      'organization_menu component[action=delete_strategy]':
        click: @deleteStrategy
      'strategy_form button[action=save]':
        click: @saveStrategy
    )
  addStrategy: (item) ->
    window = Ext.create @mainForm
    menu = Ext.ComponentQuery.query('organization_menu')[0]
    #To know what node to refresh
    window.down('form').loadRecord
      data:
        node_id: menu.node_id
        organization_id: menu.iddb
    window.show()
  editStrategy: (item) ->
    menu = Ext.ComponentQuery.query('organization_menu')[0]
    id = menu.iddb
    me = this
    if menu.node_id.match(/strats/)
      Ext.ModelManager.getModel(me.mainModel).load id,
        success: (record) ->
          window = Ext.create me.mainForm
          window.show()
          record.raw.data.node_id = menu.node_id
          window.down('form').loadRecord record.raw
  deleteStrategy: (item) ->
    menu = Ext.ComponentQuery.query('organization_menu')[0]
    if menu.node_id.match(/strats/)
      YABSCA.lib.StandardActions.deleteRecord menu.iddb, @mainModel, @getOrganizationsStore(), menu, true
  saveStrategy: (button) ->
    YABSCA.lib.StandardActions.saveRecord button, @mainModel, @getOrganizationsStore(), true
