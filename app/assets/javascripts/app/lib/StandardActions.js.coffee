Ext.define 'YABSCA.lib.StandardActions',
  singleton: true
  mainStore: ''
  mainModel: ''
  mainPanel: ''
  addRecord: (button) ->
    panel = button.up(@mainPanel)
    panel.down('form').getForm().reset()
    panel.getLayout().setActiveItem 1
  editRecord: (button) ->
    me = this
    selected_item = button.up('grid').getSelectionModel().selected
    if selected_item.length > 0
      id = selected_item.items[0].data.id
      Ext.ModelManager.getModel(me.mainModel).load id,
        success: (record) ->
          panel = button.up(me.mainPanel)
          panel.getLayout().setActiveItem 1
          panel.down('form').loadRecord record.raw
  deleteRecord: (button, callback_store) ->
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
                  if callback_store
                    callback_store()
                  else
                    me.mainStore().load()
  saveRecord: (button, callback_store) ->
    me = this
    record = Ext.create(me.mainModel, button.up('form').getValues())
    record.save
      success: ->
        button.up(me.mainPanel).getLayout().setActiveItem 0
        if typeof(callback_store) is 'function'
          callback_store()
        else
          me.mainStore().load()
  backToGrid: (button) ->
    panel = button.up(@mainPanel)
    panel.getLayout().setActiveItem 0
