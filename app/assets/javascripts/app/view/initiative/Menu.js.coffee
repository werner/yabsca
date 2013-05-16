Ext.define 'YABSCA.view.initiative.Menu',
  extend: 'Ext.menu.Menu'
  alias: 'widget.initiative_menu'
  new: 'New'
  edit: 'Edit'
  delete: 'Delete'
  initComponent: ->
    Ext.apply this,
      node_id: '' #to know what node is
      iddb: 0 #this is a property to edit and delete records easily
      items: [
        id: 'new_initiative'
        text: @new
        iconCls: 'new'
        action: 'new_initiative'
      ,
        id: 'edit_initiative'
        text: @edit
        iconCls: 'edit'
        action: 'edit_initiative'
      ,
        id: 'delete_initiative'
        text: @delete
        iconCls: 'del'
        action: 'delete_initiative'
      ]

    @callParent arguments
