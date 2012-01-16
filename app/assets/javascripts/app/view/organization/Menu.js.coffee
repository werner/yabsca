Ext.define 'YABSCA.view.organization.Menu',
  extend: 'Ext.menu.Menu'
  alias: 'widget.organization_menu'
  initComponent: ->
    Ext.apply this,
      node_id: '' #to know what node is
      iddb: 0 #this is a property to edit and delete records easily
      items: [
        text: 'Organizations'
        iconCls: 'orgs'
        menu:
          xtype: 'menu'
          items: [
            id: 'new_organization'
            text: 'New'
            iconCls: 'new'
            action: 'new_organization'
          ,
            id: 'edit_organization'
            text: 'Edit'
            iconCls: 'edit'
            action: 'edit_organization'
          ,
            id: 'delete_organization'
            text: 'Delete'
            iconCls: 'del'
            action: 'delete_organization'
          ]
      ,
        id: 'strategy_menu'
        text: 'Strategies'
        iconCls: 'strats'
        menu:
          xtype: 'menu'
          items: [
             id: 'new_strategy'
             text: 'New'
             iconCls: 'new'
             action: 'new_strategy'
           ,
             id: 'edit_strategy'
             text: 'Edit'
             iconCls: 'edit'
             action: 'edit_strategy'
           ,
             id: 'delete_strategy'
             text: 'Delete'
             iconCls: 'del'
             action: 'delete_strategy'
          ]
      ]

    @callParent arguments
