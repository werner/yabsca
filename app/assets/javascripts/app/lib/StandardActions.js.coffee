Ext.define 'YABSCA.lib.StandardActions',
  singleton: true
  contextMenu: ''
  mainModel: ''
  mainForm: ''
  mainStore: ''
  showMenu: (view, record, item, index, e) ->
    e.preventDefault() #cancel normal browser behaviour at double click
    id = record.raw.iddb
    c = Ext.create @contextMenu #creates a new menu
    c.iddb = id #gets the id from record and save it to the menu iddb property
    c.node_id = record.raw.id
    #hide delete and edit when the node selected is root
    if c.node_id is 'src:root'
      c.down('#edit').hide()
      c.down('#delete').hide()
    c.showAt e.getXY() #shows the menu at mouse cursor point
  closeMenu: (menu) ->
    menu.destroy()
  addRecord: (item) ->
    menu = item.up('menu')
    window = Ext.create @mainForm
    window.show()
    #To know what node to refresh
    window.down('form').loadRecord
      data:
        node_id: menu.node_id
        organization_id: menu.iddb
  editRecord: (item) ->
    menu = item.up('menu')
    id = menu.iddb
    me = this
    #load a record from the Model and shows it on the form
    Ext.ModelManager.getModel(@mainModel).load id,
      success: (record) ->
        window = Ext.create me.mainForm
        window.show()
        record.raw.data.node_id = menu.node_id
        window.down('form').loadRecord record.raw
  deleteRecord: (item) ->
    me = YABSCA.lib.StandardActions
    store = @mainStore()
    menu = item.up('menu')
    #load a record from the Model to delete it 
    Ext.ModelManager.getModel(@mainModel).load menu.iddb,
      success: (record) ->
        record.data = record.raw.data
        record.destroy()
        me.refreshTree(menu.node_id, store)
  saveRecord: (button) ->
    me = YABSCA.lib.StandardActions
    store = @mainStore()
    #save data from the form
    record = Ext.create(@mainModel, button.up('window').down('form').getValues())
    record.save
      success: ->
        me.refreshTree(button.up('window').down('form').getValues().node_id, store)
        button.up('window').destroy()
  refreshTree: (node_id, store) ->
    #reload the tree node
    tree = Ext.ComponentQuery.query('treepanel')[0]
    store.load
      node: tree.getStore().getNodeById(node_id).parentNode
