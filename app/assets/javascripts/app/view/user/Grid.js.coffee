Ext.define 'YABSCA.view.user.Grid',
  extend: 'Ext.grid.Panel'
  alias: 'widget.user_grid'
  initComponent: ->
    Ext.apply this,
      store: 'Users'
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
        text: 'Login'
        dataIndex: 'login'
        width: 300
      ]

    @callParent arguments
