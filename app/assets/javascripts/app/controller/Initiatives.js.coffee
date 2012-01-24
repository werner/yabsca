Ext.define 'YABSCA.controller.Initiatives',
  extend: 'Ext.app.Controller'
  stores: ['Initiatives']
  models: ['Initiative', 'Tree']
  views: ['initiative.Tree', 'initiative.Menu']
  requires: ['YABSCA.lib.TreeStandardActions']
  mainForm: 'YABSCA.view.initiative.Form'
  mainModel: 'YABSCA.model.Initiative'
  mainMenu: 'initiative_menu'
  mainTree: 'initiative_tree'
  nodeType: 'initiative'
  mainStore: ->
    @getInitiativesStore()
  init: ->
    @control(
      'initiative_tree':
        itemcontextmenu: @showMenu
      'initiative_menu':
        hide: YABSCA.lib.TreeStandardActions.closeMenu
      'initiative_menu component[action=new_initiative]':
        click: @addInitiative
      'initiative_menu component[action=edit_initiative]':
        click: YABSCA.lib.TreeStandardActions.editRecord
      'initiative_menu component[action=delete_initiative]':
        click: YABSCA.lib.TreeStandardActions.deleteRecord
      'initiative_form button[action=save]':
        click: YABSCA.lib.TreeStandardActions.saveRecord
    )
  showMenu: (view, record, item, index, e) ->
    selected_node = Ext.ComponentQuery.query('perspective_tree')[0].getSelectionModel().getSelection()[0]
    if selected_node?
      org_node_id = selected_node.internalId
      if org_node_id.match(/src:objs/)
        contextMenu = YABSCA.lib.TreeStandardActions.showMenu view, record, item, index, e, 'YABSCA.view.initiative.Menu'
        if record.raw?
          node_id = record.raw.id
        else
          node_id = record.data.id
        #hide delete and edit when the node selected is root
        if node_id is 'src:root'
          contextMenu.down('#edit_initiative').hide()
          contextMenu.down('#delete_initiative').hide()
      else
        e.preventDefault()
    else
      e.preventDefault()
  addInitiative: (item) ->
    window = Ext.create @mainForm
    menu = Ext.ComponentQuery.query('initiative_menu')[0]
    objective_id = Ext.ComponentQuery.query('perspective_tree')[0].getSelectionModel().getSelection()[0].raw.iddb
    #To know what node to refresh
    window.down('form').loadRecord
      data:
        node_id: menu.node_id
        objective_id: objective_id
    window.show()
