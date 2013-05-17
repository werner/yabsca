Ext.define 'YABSCA.view.user.Grid',
  extend: 'Ext.grid.Panel'
  alias: 'widget.user_grid'
  lang_add: 'Add'
  edit: 'Edit'
  delete: 'Delete'
  login: 'Login'
  initComponent: ->
    Ext.apply this,
      store: 'Users'
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
        ]
      ]
      columns: [
        text: @login
        dataIndex: 'login'
        width: 300
      ]

    @callParent arguments
