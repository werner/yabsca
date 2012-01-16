Ext.define 'YABSCA.controller.Organizations',
  extend: 'Ext.app.Controller'
  stores: ['Organizations']
  models: ['Organization', 'Tree']
  views: ['organization.Tree', 'organization.Menu', 'organization.Form']
  requires: ['YABSCA.lib.StandardActions']
  mainForm: 'YABSCA.view.organization.Form'
  mainModel: 'YABSCA.model.Organization'
  mainStore: ->
    @getOrganizationsStore()
  init: ->
    @control(
      'treepanel':
        itemcontextmenu: @showMenu
      'organization_menu':
        hide: YABSCA.lib.StandardActions.closeMenu
      'organization_menu component[action=new_organization]':
        click: @addOrganization
      'organization_menu component[action=edit_organization]':
        click: @editOrganization
      'organization_menu component[action=delete_organization]':
        click: @deleteOrganization
      'organization_form button[action=save]':
        click: @saveOrganization
    )
  showMenu: (view, record, item, index, e) ->
    contextMenu = YABSCA.lib.StandardActions.showMenu view, record, item, index, e, 'YABSCA.view.organization.Menu'
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
  editOrganization: (item) ->
    menu = Ext.ComponentQuery.query('organization_menu')[0]
    id = menu.iddb
    me = this
    if menu.node_id.match(/orgs/)
      #load a record from the Model and shows it on the form
      Ext.ModelManager.getModel(me.mainModel).load id,
        success: (record) ->
          window = Ext.create me.mainForm
          window.show()
          record.raw.data.node_id = menu.node_id
          window.down('form').loadRecord record.raw
  deleteOrganization: (item) ->
    menu = Ext.ComponentQuery.query('organization_menu')[0]
    if menu.node_id.match(/orgs/)
      YABSCA.lib.StandardActions.deleteRecord menu.iddb, @mainModel, @getOrganizationsStore(), menu, true
  saveOrganization: (button) ->
    YABSCA.lib.StandardActions.saveRecord button, @mainModel, @getOrganizationsStore(), true
