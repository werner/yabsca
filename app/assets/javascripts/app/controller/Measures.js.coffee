Ext.define 'YABSCA.controller.Measures',
  extend: 'Ext.app.Controller'
  stores: ['Measures', 'Periods']
  models: ['Measure', 'Tree', 'Period']
  views: ['measure.Tree', 'measure.Menu']
  requires: ['YABSCA.lib.TreeStandardActions']
  mainForm: 'YABSCA.view.measure.Form'
  mainModel: 'YABSCA.model.Measure'
  mainMenu: 'measure_menu'
  mainTree: 'measure_tree'
  nodeType: 'measure'
  mainStore: ->
    @getMeasuresStore()
  init: ->
    @control(
      'measure_tree':
        itemcontextmenu: @showMenu
      'measure_menu':
        hide: YABSCA.lib.TreeStandardActions.closeMenu
      'measure_menu component[action=new_measure]':
        click: @addMeasure
      'measure_menu component[action=edit_measure]':
        click: YABSCA.lib.TreeStandardActions.editRecord
      'measure_menu component[action=delete_measure]':
        click: YABSCA.lib.TreeStandardActions.deleteRecord
      'measure_form button[action=save]':
        click: YABSCA.lib.TreeStandardActions.saveRecord
    )
  showMenu: (view, record, item, index, e) ->
    selected_node = Ext.ComponentQuery.query('perspective_tree')[0].getSelectionModel().getSelection()[0]
    if selected_node?
      org_node_id = selected_node.internalId
      if org_node_id.match(/src:objs/)
        contextMenu = YABSCA.lib.TreeStandardActions.showMenu view, record, item, index, e, 'YABSCA.view.measure.Menu'
        if record.raw?
          node_id = record.raw.id
        else
          node_id = record.data.id
        #hide delete and edit when the node selected is root
        if node_id is 'src:root'
          contextMenu.down('#edit_measure').hide()
          contextMenu.down('#delete_measure').hide()
      else
        e.preventDefault()
    else
      e.preventDefault()
  addMeasure: (item) ->
    window = Ext.create @mainForm
    menu = Ext.ComponentQuery.query('measure_menu')[0]
    objective_id = Ext.ComponentQuery.query('perspective_tree')[0].getSelectionModel().getSelection()[0].raw.iddb
    #To know what node to refresh
    window.down('form').loadRecord
      data:
        node_id: menu.node_id
        objective_ids: objective_id
    window.show()
