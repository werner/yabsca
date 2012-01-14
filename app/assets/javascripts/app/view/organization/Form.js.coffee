Ext.define 'YABSCA.view.organization.Form',
  extend: 'Ext.window.Window'
  alias: 'widget.organization_form'
  requires: ['Ext.form.Panel']
  height: 350
  width: 400
  closeAction: 'hide'
  title: 'Organization'
  layout: 'fit'
  initComponent: ->
    Ext.apply this,
      buttons: [
        text: 'Save'
        iconCls: 'save'
        action: 'save'
      ,
        text: 'Close'
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
          name: 'organization_id'
          value: 0
        ,
          xtype: 'textfield'
          name: 'name'
          fieldLabel: 'Name'
          allowBlank: false
        ,
          name: 'vision'
          fieldLabel: 'Vision'
        ,
          name: 'goal'
          fieldLabel: 'Goal'
        ,
          name: 'description'
          fieldLabel: 'Description'
        ]
      ]

    @callParent arguments
