Ext.define 'YABSCA.controller.Objectives',
  extend: 'Ext.app.Controller'
  stores: ['Perspectives']
  models: ['Objective']
  views: ['objective.Form']
  requires: ['YABSCA.lib.TreeStandardActions']
  mainForm: 'YABSCA.view.objective.Form'
  mainModel: 'YABSCA.model.Objective'
  mainMenu: 'perspective_menu'
  nodeType: 'objs'
  mainStore: ->
    @getPerspectivesStore()
  init: ->
    @control(
      'perspective_menu component[action=new_objective]':
        click: @addObjective
      'perspective_menu component[action=edit_objective]':
        click: YABSCA.lib.TreeStandardActions.editRecord
      'perspective_menu component[action=delete_objective]':
        click: YABSCA.lib.TreeStandardActions.deleteRecord
      'objective_form button[action=save]':
        click: YABSCA.lib.TreeStandardActions.saveRecord
    )
  addObjective: (item) ->
    window = Ext.create @mainForm
    menu = Ext.ComponentQuery.query('perspective_menu')[0]
    init_data = { data: { node_id: menu.node_id  } }
    if menu.node_id.match(/src:persp/)
      init_data.data.perspective_id = menu.iddb
    else if menu.node_id.match(/src:objs/)
      init_data.data.objective_id = menu.iddb
    #To know what node to refresh
    window.down('form').loadRecord init_data
    window.show()
