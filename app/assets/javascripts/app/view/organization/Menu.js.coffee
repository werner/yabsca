Ext.define 'YABSCA.view.organization.Menu',
  extend: 'Ext.menu.Menu'
  alias: 'widget.organization_menu'
  initComponent: ->
    Ext.apply this,
      node_id: 0 #to know what node is
      iddb: 0 #this is a property to edit and delete records easily
      items: [
        id: 'new'
        text: 'New'
        iconCls: 'new'
        action: 'new'
      ,
        id: 'edit'
        text: 'Edit'
        iconCls: 'edit'
        action: 'edit'
      ,
        id: 'delete'
        text: 'Delete'
        iconCls: 'del'
        action: 'delete'
      ]

    @callParent arguments
