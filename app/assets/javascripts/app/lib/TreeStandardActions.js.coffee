Ext.define 'YABSCA.lib.TreeStandardActions',
  singleton: true
  mainStore: ''
  mainForm: ''
  mainModel: ''
  showMenu: (view, record, item, index, e, menu) ->
    e.preventDefault() #cancel normal browser behaviour at double click
    id = record.raw.iddb
    contextMenu = Ext.create menu #creates a new menu
    contextMenu.iddb = id #gets the id from record and save it to the menu iddb property
    contextMenu.node_id = record.raw.id
    contextMenu.showAt e.getXY() #shows the menu at mouse cursor point
    contextMenu
  closeMenu: (menu) ->
    menu.destroy()
  editRecord: (item) ->
    menu = Ext.ComponentQuery.query(@mainMenu)[0]
    id = menu.iddb
    me = this
    if menu.node_id.match(@nodeType)
      #load a record from the Model and shows it on the form
      Ext.ModelManager.getModel(me.mainModel).load id,
        success: (record) ->
          window = Ext.create me.mainForm
          window.show()
          record.raw.data.node_id = menu.node_id
          window.down('form').loadRecord record.raw
  deleteRecord: (button) ->
    me = YABSCA.lib.TreeStandardActions
    menu = Ext.ComponentQuery.query(@mainMenu)[0]
    store = @mainStore()
    model = @mainModel
    if menu.node_id.match(@nodeType)
      Ext.MessageBox.confirm 'Delete', 'Are you sure?', (button) ->
        if button is "yes"
          #load a record from the Model to delete it 
          Ext.ModelManager.getModel(model).load menu.iddb,
            success: (record) ->
              record.data = record.raw.data
              record.destroy()
              me.refreshTree(menu.node_id, store)
  saveRecord: (button) ->
    me = YABSCA.lib.TreeStandardActions
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
