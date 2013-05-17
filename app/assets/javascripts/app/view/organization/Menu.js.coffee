Ext.define 'YABSCA.view.organization.Menu',
  extend: 'Ext.menu.Menu'
  alias: 'widget.organization_menu'
  new: 'New'
  edit: 'Edit'
  delete: 'Delete'
  organizations: 'Organizations'
  strategies: 'Strategies'
  initComponent: ->
    Ext.apply this,
      node_id: '' #to know what node is
      iddb: 0 #this is a property to edit and delete records easily
      items: [
        text: @organizations
        iconCls: 'orgs'
        menu:
          xtype: 'menu'
          items: [
            id: 'new_organization'
            text: @new
            iconCls: 'new'
            action: 'new_organization'
          ,
            id: 'edit_organization'
            text: @edit
            iconCls: 'edit'
            action: 'edit_organization'
          ,
            id: 'delete_organization'
            text: @delete
            iconCls: 'del'
            action: 'delete_organization'
          ]
      ,
        id: 'strategy_menu'
        text: @strategies
        iconCls: 'strats'
        menu:
          xtype: 'menu'
          items: [
             id: 'new_strategy'
             text: @new
             iconCls: 'new'
             action: 'new_strategy'
           ,
             id: 'edit_strategy'
             text: @edit
             iconCls: 'edit'
             action: 'edit_strategy'
           ,
             id: 'delete_strategy'
             text: @delete
             iconCls: 'del'
             action: 'delete_strategy'
          ]
      ]

    @callParent arguments
