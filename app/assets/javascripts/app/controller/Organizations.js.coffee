Ext.define 'YABSCA.controller.Organizations',
  extend: 'Ext.app.Controller'
  stores: ['Organizations']
  models: ['Organization', 'Tree']
  views: ['organization.Tree', 'organization.Menu', 'organization.Form']
  init: ->
    @control(
      'organization_tree':
        itemcontextmenu: @showMenu
      'organization_menu':
        hide: @closeMenu
      'organization_menu component[action=new]':
        click: @addOrganization
      'organization_menu component[action=edit]':
        click: @editOrganization
      'organization_menu component[action=delete]':
        click: @deleteOrganization
      'organization_form button[action=save]':
        click: @saveOrganization
    )
  showMenu: (view, record, item, index, e) ->
    e.preventDefault() #cancel normal browser behaviour at double click
    id = record.raw.iddb
    c = Ext.create 'YABSCA.view.organization.Menu' #creates a new menu
    c.iddb = id #gets the id from record and save it to the menu iddb property
    c.node_id = record.raw.id
    #hide delete and edit when the node selected is root
    if c.node_id is 'src:root'
      c.down('#edit').hide()
      c.down('#delete').hide()
    c.showAt e.getXY() #shows the menu at mouse cursor point
  closeMenu: (menu) ->
    menu.destroy()
  addOrganization: (item) ->
    window = Ext.create 'YABSCA.view.organization.Form'
    window.show()
    #To know what node to refresh
    window.down('form').loadRecord
      data:
        node_id: item.up('menu').node_id
        organization_id: item.up('menu').iddb
    item.up('menu').destroy()
  editOrganization: (item) ->
    id = item.up('menu').iddb
    #load a record from the Model and shows it on the form
    Ext.ModelManager.getModel('YABSCA.model.Organization').load id,
      success: (record) ->
        window = Ext.create 'YABSCA.view.organization.Form'
        window.show()
        record.raw.data.node_id = item.up('menu').node_id
        window.down('form').loadRecord record.raw
        item.up('menu').destroy()
  deleteOrganization: (item) ->
    me = this
    id = item.up('menu').iddb
    #load a record from the Model to delete it 
    Ext.ModelManager.getModel('YABSCA.model.Organization').load id,
      success: (record) ->
        record.data = record.raw.data
        record.destroy()
        me.refreshTree(item.up('menu').node_id)
  saveOrganization: (button) ->
    me = this
    #save data from the form
    organization = Ext.create('YABSCA.model.Organization', button.up('window').down('form').getValues())
    organization.save
      success: ->
        me.refreshTree(button.up('window').down('form').getValues().node_id)
        button.up('window').destroy()
  refreshTree: (node_id) ->
    #reload the tree node
    me = this
    tree = Ext.ComponentQuery.query('organization_tree')[0]
    me.getOrganizationsStore().load
      node: tree.getStore().getNodeById(node_id).parentNode
