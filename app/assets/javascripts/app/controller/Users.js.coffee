Ext.define 'YABSCA.controller.Users',
  extend: 'Ext.app.Controller'
  stores: ['Users']
  models: ['User']
  views: ['user.Form', 'user.Grid', 'user.Window']
  requires: ['YABSCA.lib.StandardActions']
  mainModel: 'YABSCA.model.User'
  mainPanel: 'user_window'
  mainStore: ->
    @getUsersStore()
  init: ->
    @control(
      'user_grid button[action=add]':
        click: YABSCA.lib.StandardActions.addRecord
      'user_grid button[action=edit]':
        click: YABSCA.lib.StandardActions.editRecord
      'user_grid button[action=delete]':
        click: YABSCA.lib.StandardActions.deleteRecord
      'user_form button[action=back]':
        click: YABSCA.lib.StandardActions.backToGrid
      'user_form button[action=save]':
        click: YABSCA.lib.StandardActions.saveRecord
    )
