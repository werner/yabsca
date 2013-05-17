Ext.define 'YABSCA.view.objective.Form',
  extend: 'Ext.window.Window'
  alias: 'widget.objective_form'
  requires: ['Ext.form.Panel']
  height: 150
  width: 400
  closeAction: 'hide'
  title: 'Objective'
  layout: 'fit'
  save: 'Save'
  close: 'Close'
  name: 'Name'
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
        items: [
          xtype: 'hiddenfield'
          name: 'id'
        ,
          xtype: 'hiddenfield'
          name: 'node_id'
        ,
          xtype: 'hiddenfield'
          name: 'perspective_id'
          value: 0
        ,
          xtype: 'hiddenfield'
          name: 'objective_id'
          value: 0
        ,
          xtype: 'textfield'
          name: 'name'
          fieldLabel: @name
          allowBlank: false
        ]
      ]

    @callParent arguments
