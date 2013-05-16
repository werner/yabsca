Ext.define 'YABSCA.view.initiative.Form',
  extend: 'Ext.window.Window'
  alias: 'widget.initiative_form'
  requires: ['Ext.form.Panel']
  height: 350
  width: 400
  closeAction: 'hide'
  title: 'Initiative'
  layout: 'fit'
  save: 'Save'
  close: 'Close'
  code: 'Code'
  name: 'Name'
  completed: '% Completed'
  beginning: 'Beginning'
  end: 'End'
  initComponent: ->
    Ext.apply this,
      buttons: [
        text: @save
        iconCls: 'save'
        action: 'save'
      ,
        text: @close
        iconCls: 'close'
        scope: this
        handler: @destroy
      ]
      items: [
        xtype: 'form'
        bodyStyle: 'padding: 15px'
        labelWidth: 75
        defaults:
          width: 330
        defaultType: 'textfield'
        items: [
          xtype: 'hiddenfield'
          name: 'id'
        ,
          xtype: 'hiddenfield'
          name: 'node_id'
        ,
          xtype: 'hiddenfield'
          name: 'objective_id'
          value: 0
        ,
          xtype: 'hiddenfield'
          name: 'initiative_id'
          value: 0
        ,
          xtype: 'hiddenfield'
          name: 'responsible_id'
          value: 0
        ,
          name: 'code'
          fieldLabel: @code
          allowBlank: false
        ,
          name: 'name'
          fieldLabel: @name
          allowBlank: false
        ,
          xtype: 'numberfield'
          name: 'completed'
          fieldLabel: @completed
        ,
          xtype: 'datefield'
          name: 'beginning'
          fieldLabel: @beginning
          submitFormat: 'Y/m/d'
        ,
          xtype: 'datefield'
          name: 'end'
          fieldLabel: @end
          submitFormat: 'Y/m/d'
        ]
      ]

    @callParent arguments
