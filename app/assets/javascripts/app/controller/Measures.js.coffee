Ext.define 'YABSCA.controller.Measures',
  extend: 'Ext.app.Controller'
  stores: ['Measures','Targets', 'Periods']
  models: ['Measure', 'Tree', 'Period']
  views: ['measure.Tree', 'measure.Menu', 'measure.Form', 'measure.Formula']
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
        itemclick: @itemTreeClick
      'measure_menu':
        hide: YABSCA.lib.TreeStandardActions.closeMenu
      'measure_menu component[action=new_measure]':
        click: @addMeasure
      'measure_menu component[action=edit_measure]':
        click: YABSCA.lib.TreeStandardActions.editRecord
      'measure_menu component[action=delete_measure]':
        click: YABSCA.lib.TreeStandardActions.deleteRecord
      'measure_menu component[action=formula]':
        click: @showFormula
      'measure_formula component[action=save]':
        click: YABSCA.lib.TreeStandardActions.saveRecord
      'measure_form button[action=save]':
        click: YABSCA.lib.TreeStandardActions.saveRecord
    )
  itemTreeClick: (view, record, item, index, e) ->
    if record.raw?
      id = record.raw.iddb
      @getTargetsStore().load
        params:
          measure_id: id
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
  showFormula: (item) ->
    menu = Ext.ComponentQuery.query(@mainMenu)[0]
    id = menu.iddb
    me = this
    if menu.node_id.match(@nodeType)
      #load a record from the Model and shows it on the form
      Ext.ModelManager.getModel(me.mainModel).load id,
        success: (record) ->
          window = Ext.create 'YABSCA.view.measure.Formula'
          window.show()
          record.raw.data.node_id = menu.node_id
          window.down('form').loadRecord record.raw
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
