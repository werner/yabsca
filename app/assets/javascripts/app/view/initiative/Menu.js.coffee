Ext.define 'YABSCA.view.initiative.Menu',
  extend: 'Ext.menu.Menu'
  alias: 'widget.initiative_menu'
  initComponent: ->
    Ext.apply this,
      node_id: '' #to know what node is
      iddb: 0 #this is a property to edit and delete records easily
      items: [
        id: 'new_initiative'
        text: 'New'
        iconCls: 'new'
        action: 'new_initiative'
      ,
        id: 'edit_initiative'
        text: 'Edit'
        iconCls: 'edit'
        action: 'edit_initiative'
      ,
        id: 'delete_initiative'
        text: 'Delete'
        iconCls: 'del'
        action: 'delete_initiative'
      ]

    @callParent arguments
