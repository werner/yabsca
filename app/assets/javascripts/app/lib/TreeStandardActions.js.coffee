Ext.define 'YABSCA.lib.TreeStandardActions',
  singleton: true
  mainStore: ''
  mainForm: ''
  mainModel: ''
  mainTree: ''
  showMenu: (view, record, item, index, e, menu) ->
    e.preventDefault() #cancel normal browser behaviour at double click
    contextMenu = Ext.create menu #creates a new menu
    if record.raw is undefined
      id = record.data.iddb
      contextMenu.node_id = record.data.id
    else
      id = record.raw.iddb
      contextMenu.node_id = record.raw.id
    contextMenu.iddb = id #gets the id from record and save it to the menu iddb property
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
    tree = Ext.ComponentQuery.query(@mainTree)[0]
    if menu.node_id.match(@nodeType)
      Ext.MessageBox.confirm 'Delete', 'Are you sure?', (button) ->
        if button is "yes"
          #load a record from the Model to delete it 
          Ext.ModelManager.getModel(model).load menu.iddb,
            success: (record) ->
              record.data = record.raw.data
              record.destroy()
              me.refreshTree(menu.node_id, store, tree)
  saveRecord: (button) ->
    me = YABSCA.lib.TreeStandardActions
    store = @mainStore()
    tree = Ext.ComponentQuery.query(@mainTree)[0]
    #save data from the form
    record = Ext.create @mainModel, button.up('window').down('form').getValues()
    record.save
      success: ->
        me.refreshTree(button.up('window').down('form').getValues().node_id, store, tree)
        button.up('window').destroy()
  refreshTree: (node_id, store, tree) ->
    #reload the tree node
    store.load
      params:
        node: tree.getStore().getNodeById(node_id).parentNode
        node_id: tree.getRootNode().data.node_id
