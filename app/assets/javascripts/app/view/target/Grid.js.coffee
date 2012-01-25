Ext.define 'YABSCA.view.target.Grid',
  extend: 'Ext.grid.Panel'
  alias: 'widget.target_grid'
  initComponent: ->
    Ext.apply this,
      store: 'Targets'
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
        text: 'Period'
        dataIndex: 'period'
        width: 150
      ,
        text: 'Goal'
        dataIndex: 'goal'
        width: 150
      ,
        text: 'Achieved'
        dataIndex: 'achieved'
        width: 150
      ]

    @callParent arguments
