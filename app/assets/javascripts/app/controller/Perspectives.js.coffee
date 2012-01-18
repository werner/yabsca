Ext.define 'YABSCA.controller.Perspectives',
  extend: 'Ext.app.Controller'
  stores: ['Perspectives']
  models: ['Perspective']
  views: ['perspective.Tree', 'perspective.Menu', 'perspective.Form']
  requires: ['YABSCA.lib.TreeStandardActions']
  mainForm: 'YABSCA.view.perspective.Form'
  mainModel: 'YABSCA.model.Perspective'
  mainMenu: 'perspective_menu'
  nodeType: 'persp'
  mainStore: ->
    @getPerspectivesStore()
  init: ->
    @control(
      'perspective_menu component[action=new_perspective]':
        click: @addPerspective
      'perspective_menu component[action=edit_perspective]':
        click: YABSCA.lib.TreeStandardActions.editRecord
      'perspective_menu component[action=delete_perspective]':
        click: YABSCA.lib.TreeStandardActions.deleteRecord
      'perspective_form button[action=save]':
        click: YABSCA.lib.TreeStandardActions.saveRecord
    )
  addPerspective: (item) ->
    window = Ext.create @mainForm
    menu = Ext.ComponentQuery.query('perspective_menu')[0]
    #To know what node to refresh
    window.down('form').loadRecord
      data:
        node_id: menu.node_id
        strategy_id: menu.iddb
    window.show()
