Ext.define 'YABSCA.view.target.Grid',
  extend: 'Ext.grid.Panel'
  alias: 'widget.target_grid'
  lang_add: 'Add'
  edit: 'Edit'
  delete: 'Delete'
  calculate: 'Calculate'
  period: 'Period'
  goal: 'Goal'
  achieved: 'Achieved'
  initComponent: ->
    Ext.apply this,
      store: 'Targets'
      dockedItems: [
        xtype: 'toolbar'
        items: [
          iconCls: 'new'
          text: @lang_add
          action: 'add'
        ,
          iconCls: 'edit'
          text: @edit
          action: 'edit'
        ,
          iconCls: 'del'
          text: @delete
          action: 'delete'
        ,
          iconCls: 'calc'
          text: @calculate
          action: 'calculate'
        ]
      ]
      columns: [
        text: @period
        dataIndex: 'period'
        width: 150
      ,
        text: @goal
        dataIndex: 'goal'
        width: 150
      ,
        text: @achieved
        dataIndex: 'achieved'
        width: 150
      ]

    @callParent arguments
