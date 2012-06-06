Ext.define 'YABSCA.view.perspective.Menu',
  extend: 'Ext.menu.Menu'
  alias: 'widget.perspective_menu'
  initComponent: ->
    Ext.apply this,
      node_id: '' #to know what node is
      iddb: 0 #this is a property to edit and delete records easily
      items: [
        text: 'Perspectives'
        iconCls: 'persp'
        menu:
          xtype: 'menu'
          items: [
            id: 'new_perspective'
            text: 'New'
            iconCls: 'new'
            action: 'new_perspective'
          ,
            id: 'edit_perspective'
            text: 'Edit'
            iconCls: 'edit'
            action: 'edit_perspective'
          ,
            id: 'delete_perspective'
            text: 'Delete'
            iconCls: 'del'
            action: 'delete_perspective'
          ]
      ,
        id: 'objective_menu'
        text: 'Objectives'
        iconCls: 'objs'
        menu:
          xtype: 'menu'
          items: [
             id: 'new_objective'
             text: 'New'
             iconCls: 'new'
             action: 'new_objective'
           ,
             id: 'edit_objective'
             text: 'Edit'
             iconCls: 'edit'
             action: 'edit_objective'
           ,
             id: 'delete_objective'
             text: 'Delete'
             iconCls: 'del'
             action: 'delete_objective'
          ,
            id: 'gantt'
            text: 'Gantt'
            iconCls: 'gantt_icon'
            action: 'show_gantt'
          ]
      ]

    @callParent arguments
