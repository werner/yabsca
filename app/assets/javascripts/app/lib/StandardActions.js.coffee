Ext.define 'YABSCA.lib.StandardActions',
  singleton: true
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
  deleteRecord: (id, model, store, menu, tree) ->
    me = YABSCA.lib.StandardActions
    Ext.MessageBox.confirm 'Delete', 'Are you sure?', (button) ->
      if button is "yes"
        #load a record from the Model to delete it 
        Ext.ModelManager.getModel(model).load id,
          success: (record) ->
            record.data = record.raw.data
            record.destroy()
            if tree
              me.refreshTree(menu.node_id, store)
  saveRecord: (button, model, store, tree) ->
    me = YABSCA.lib.StandardActions
    #save data from the form
    record = Ext.create(model, button.up('window').down('form').getValues())
    record.save
      success: ->
        if tree
          me.refreshTree(button.up('window').down('form').getValues().node_id, store)
        button.up('window').destroy()
  refreshTree: (node_id, store) ->
    #reload the tree node
    tree = Ext.ComponentQuery.query('treepanel')[0]
    store.load
      node: tree.getStore().getNodeById(node_id).parentNode
