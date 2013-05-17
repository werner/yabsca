Ext.define 'YABSCA.view.perspective.Form',
  extend: 'Ext.window.Window'
  alias: 'widget.perspective_form'
  requires: ['Ext.form.Panel']
  height: 150
  width: 400
  closeAction: 'hide'
  title: 'Perspective'
  layout: 'fit'
  save: 'Save'
  name: 'Name'
  close: 'Close'
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
        defaultType: 'textareafield'
        items: [
          xtype: 'hiddenfield'
          name: 'id'
        ,
          xtype: 'hiddenfield'
          name: 'node_id'
        ,
          xtype: 'hiddenfield'
          name: 'strategy_id'
          value: 0
        ,
          xtype: 'textfield'
          name: 'name'
          fieldLabel: @name
          allowBlank: false
        ]
      ]

    @callParent arguments
