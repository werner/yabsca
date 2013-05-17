Ext.define 'YABSCA.view.responsible.Grid',
  extend: 'Ext.grid.Panel'
  alias: 'widget.responsible_grid'
  lang_add: 'Add'
  edit: 'Edit'
  delete: 'Delete'
  name: 'Name'
  initComponent: ->
    Ext.apply this,
      store: 'Responsibles'
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
        text: @name
        dataIndex: 'name'
        width: 300
      ]

    @callParent arguments
