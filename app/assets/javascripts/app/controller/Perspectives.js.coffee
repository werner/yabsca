Ext.define 'YABSCA.controller.Perspectives',
  extend: 'Ext.app.Controller'
  stores: ['Perspectives', 'Measures']
  models: ['Perspective']
  views: ['perspective.Tree', 'perspective.Menu', 'perspective.Form']
  requires: ['YABSCA.lib.TreeStandardActions']
  mainForm: 'YABSCA.view.perspective.Form'
  mainModel: 'YABSCA.model.Perspective'
  mainMenu: 'perspective_menu'
  mainTree: 'perspective_tree'
  nodeType: 'persp'
  mainStore: ->
    @getPerspectivesStore()
  init: ->
    @control(
      'perspective_tree':
        itemcontextmenu: @showMenu
        itemclick: @itemTreeClick
      'perspective_menu':
        hide: YABSCA.lib.TreeStandardActions.closeMenu
      'perspective_menu component[action=new_perspective]':
        click: @addPerspective
      'perspective_menu component[action=edit_perspective]':
        click: YABSCA.lib.TreeStandardActions.editRecord
      'perspective_menu component[action=delete_perspective]':
        click: YABSCA.lib.TreeStandardActions.deleteRecord
      'perspective_form button[action=save]':
        click: YABSCA.lib.TreeStandardActions.saveRecord
    )
  showMenu: (view, record, item, index, e) ->
    #get the node from organization_tree
    selected_node = Ext.ComponentQuery.query('organization_tree')[0].getSelectionModel().getSelection()[0]
    if selected_node?
      org_node_id = selected_node.internalId
      #Shows menu only if it is an strategy
      if org_node_id.match(/src:strats/)
        contextMenu = YABSCA.lib.TreeStandardActions.showMenu view, record, item, index, e, 'YABSCA.view.perspective.Menu'
        node_id = record.data.id
        #hide delete and edit when the node selected is root
        if node_id is 'src:root'
          contextMenu.down('#edit_perspective').hide()
          contextMenu.down('#delete_perspective').hide()
          contextMenu.down('#objective_menu').hide()
        else if node_id.match(/src:persp/)
          contextMenu.down('#new_perspective').hide()
          contextMenu.down('#edit_objective').hide()
          contextMenu.down('#delete_objective').hide()
      else
        e.preventDefault()
    else
      e.preventDefault()
  itemTreeClick: (view, record, item, index, e) ->
    #Load id on root
    if record.raw?
      node_id = record.raw.id
      id = record.raw.iddb
    else
      node_id = record.data.id
      id = record.data.iddb
    #Load the root in measures so it knows it is an objective
    Ext.ComponentQuery.query('measure_tree')[0].setRootNode
      text: 'Measures'
      id: 'src:root'
      node_id: 'src:root' + id
      expanded: true
      draggable: false
      iconCls: 'measure'
      iddb: 0
    @getMeasuresStore().load
      params:
        node_id: node_id
  addPerspective: (item) ->
    window = Ext.create @mainForm
    menu = Ext.ComponentQuery.query('perspective_menu')[0]
    strategy_id = Ext.ComponentQuery.query('organization_tree')[0].getSelectionModel().getSelection()[0].raw.iddb
    #To know what node to refresh
    window.down('form').loadRecord
      data:
        node_id: menu.node_id
        strategy_id: strategy_id
    window.show()
