Ext.define 'YABSCA.lib.StandardActions',
  singleton: true
  mainStore: ''
  mainModel: ''
  addRecord: (button) ->
    window = button.up('window')
    window.down('form').getForm().reset()
    window.getLayout().setActiveItem 1
  editRecord: (button) ->
    me = this
    selected_item = button.up('grid').getSelectionModel().selected
    if selected_item.length > 0
      id = selected_item.items[0].data.id
      Ext.ModelManager.getModel(me.mainModel).load id,
        success: (record) ->
          window = button.up('window')
          window.getLayout().setActiveItem 1
          window.down('form').loadRecord record.raw
  deleteRecord: (button) ->
    me = this
    selected_item = button.up('grid').getSelectionModel().selected
    if selected_item.length > 0
      Ext.MessageBox.confirm 'Delete', 'Are you sure?', (button) ->
        if button is "yes"
          id = selected_item.items[0].data.id
          Ext.ModelManager.getModel(me.mainModel).load id,
            success: (record) ->
              record.data = record.raw.data
              record.destroy
                success: ->
                  me.mainStore().load()
  saveRecord: (button) ->
    me = this
    record = Ext.create(me.mainModel, button.up('form').getValues())
    record.save
      success: ->
        button.up('window').getLayout().setActiveItem 0
        me.mainStore().load()
  backToGrid: (button) ->
    window = button.up('window')
    window.getLayout().setActiveItem 0
