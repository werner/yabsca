Ext.define 'YABSCA.controller.Strategies',
  extend: 'Ext.app.Controller'
  stores: ['Organizations']
  models: ['Strategy']
  views: ['strategy.Form']
  requires: ['YABSCA.lib.TreeStandardActions']
  mainForm: 'YABSCA.view.strategy.Form'
  mainModel: 'YABSCA.model.Strategy'
  mainMenu: 'organization_menu'
  mainTree: 'organization_tree'
  nodeType: 'strats'
  mainStore: ->
    @getOrganizationsStore()
  init: ->
    @control(
      'organization_menu component[action=new_strategy]':
        click: @addStrategy
      'organization_menu component[action=edit_strategy]':
        click: YABSCA.lib.TreeStandardActions.editRecord
      'organization_menu component[action=delete_strategy]':
        click: YABSCA.lib.TreeStandardActions.deleteRecord
      'strategy_form button[action=save]':
        click: YABSCA.lib.TreeStandardActions.saveRecord
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
