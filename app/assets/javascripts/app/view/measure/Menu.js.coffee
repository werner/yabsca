Ext.define 'YABSCA.view.measure.Menu',
  extend: 'Ext.menu.Menu'
  alias: 'widget.measure_menu'
  new: 'New'
  edit: 'Edit'
  delete: 'Delete'
  chart: 'Chart'
  initComponent: ->
    Ext.apply this,
      node_id: '' #to know what node is
      iddb: 0 #this is a property to edit and delete records easily
      items: [
        id: 'new_measure'
        text: @new
        iconCls: 'new'
        action: 'new_measure'
      ,
        id: 'edit_measure'
        text: @edit
        iconCls: 'edit'
        action: 'edit_measure'
      ,
        id: 'delete_measure'
        text: @delete
        iconCls: 'del'
        action: 'delete_measure'
      ,
        id: 'formula'
        text: 'Formula'
        iconCls: 'formula_icon'
        action: 'formula'
      ,
        id: 'chart'
        text: @chart
        iconCls: 'chart'
        action: 'chart'
      ]

    @callParent arguments
