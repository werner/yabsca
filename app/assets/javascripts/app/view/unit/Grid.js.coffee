Ext.define 'YABSCA.view.unit.Grid',
  extend: 'Ext.grid.Panel'
  alias: 'widget.unit_grid'
  initComponent: ->
    Ext.apply this,
      store: 'Units'
      dockedItems: [
        xtype: 'toolbar'
        items: [
          iconCls: 'new'
          text: 'Add'
          action: 'add'
        ,
          iconCls: 'edit'
          text: 'Edit'
          action: 'edit'
        ,
          iconCls: 'del'
          text: 'Delete'
          action: 'delete'
        ]
      ]
      columns: [
        text: 'Name'
        dataIndex: 'name'
        width: 300
      ]

    @callParent arguments
