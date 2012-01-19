Ext.define 'YABSCA.controller.Organizations',
  extend: 'Ext.app.Controller'
  stores: ['Organizations', 'Perspectives']
  models: ['Organization', 'Tree']
  views: ['organization.Tree', 'organization.Menu', 'organization.Form']
  requires: ['YABSCA.lib.TreeStandardActions']
  mainForm: 'YABSCA.view.organization.Form'
  mainModel: 'YABSCA.model.Organization'
  mainMenu: 'organization_menu'
  mainTree: 'organization_tree'
  nodeType: 'orgs'
  mainStore: ->
    @getOrganizationsStore()
  init: ->
    @control(
      'organization_tree':
        itemcontextmenu: @showMenu
        itemclick: @itemTreeClick
      'organization_menu':
        hide: YABSCA.lib.TreeStandardActions.closeMenu
      'organization_menu component[action=new_organization]':
        click: @addOrganization
      'organization_menu component[action=edit_organization]':
        click: YABSCA.lib.TreeStandardActions.editRecord
      'organization_menu component[action=delete_organization]':
        click: YABSCA.lib.TreeStandardActions.deleteRecord
      'organization_form button[action=save]':
        click: YABSCA.lib.TreeStandardActions.saveRecord
    )
  showMenu: (view, record, item, index, e) ->
    contextMenu = YABSCA.lib.TreeStandardActions.showMenu view, record, item, index, e, 'YABSCA.view.organization.Menu'
    if record.raw?
      node_id = record.raw.id
    else
      node_id = record.data.id
    #hide delete and edit when the node selected is root
    if node_id is 'src:root'
      contextMenu.down('#edit_organization').hide()
      contextMenu.down('#delete_organization').hide()
      contextMenu.down('#strategy_menu').hide()
  itemTreeClick: (view, record, item, index, e) ->
    if record.raw?
      node_id = record.raw.id
      id = record.raw.iddb
    else
      node_id = record.data.id
      id = record.data.iddb
    Ext.ComponentQuery.query('perspective_tree')[0].setRootNode
      text: 'Perspectives'
      id: 'src:root'
      node_id: 'src:root' + id
      expanded: true
      draggable: false
      iconCls: 'persp'
      iddb: 0
    @getPerspectivesStore().load
      params:
        node_id: node_id
  addOrganization: (item) ->
    window = Ext.create @mainForm
    menu = Ext.ComponentQuery.query('organization_menu')[0]
    #To know what node to refresh
    window.down('form').loadRecord
      data:
        node_id: menu.node_id
        organization_id: menu.iddb
    window.show()
