Ext.define 'YABSCA.controller.Organizations',
  extend: 'Ext.app.Controller'
  stores: ['Organizations']
  models: ['Organization', 'Tree']
  views: ['organization.Tree', 'organization.Menu', 'organization.Form']
  requires: ['YABSCA.lib.TreeStandardActions']
  mainForm: 'YABSCA.view.organization.Form'
  mainModel: 'YABSCA.model.Organization'
  mainMenu: 'organization_menu'
  nodeType: 'orgs'
  mainStore: ->
    @getOrganizationsStore()
  init: ->
    @control(
      'treepanel':
        itemcontextmenu: @showMenu
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
    node_id = record.raw.id
    #hide delete and edit when the node selected is root
    if node_id is 'src:root'
      contextMenu.down('#edit_organization').hide()
      contextMenu.down('#delete_organization').hide()
      contextMenu.down('#strategy_menu').hide()
  addOrganization: (item) ->
    window = Ext.create @mainForm
    menu = Ext.ComponentQuery.query('organization_menu')[0]
    #To know what node to refresh
    window.down('form').loadRecord
      data:
        node_id: menu.node_id
        organization_id: menu.iddb
    window.show()
