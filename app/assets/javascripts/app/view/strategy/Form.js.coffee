Ext.define 'YABSCA.view.strategy.Form',
  extend: 'Ext.window.Window'
  alias: 'widget.strategy_form'
  requires: ['Ext.form.Panel']
  height: 250
  width: 400
  closeAction: 'hide'
  title: 'Strategy'
  layout: 'fit'
  save: 'Save'
  name: 'Name'
  close: 'Close'
  description: 'Description'
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
          name: 'organization_id'
          value: 0
        ,
          xtype: 'textfield'
          name: 'name'
          fieldLabel: @name
          allowBlank: false
        ,
          xtype: 'textareafield'
          name: 'description'
          fieldLabel: @description
        ]
      ]

    @callParent arguments
