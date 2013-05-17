Ext.define 'YABSCA.view.organization.Form',
  extend: 'Ext.window.Window'
  alias: 'widget.organization_form'
  requires: ['Ext.form.Panel']
  height: 350
  width: 400
  closeAction: 'hide'
  title: 'Organization'
  layout: 'fit'
  name: 'Name'
  vision: 'Vision'
  goal: 'Goal'
  description: 'Description'
  save: 'Save'
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
          name: 'organization_id'
          value: 0
        ,
          xtype: 'textfield'
          name: 'name'
          fieldLabel: @name
          allowBlank: false
        ,
          name: 'vision'
          fieldLabel: @vision
        ,
          name: 'goal'
          fieldLabel: @goal
        ,
          name: 'description'
          fieldLabel: @description
        ]
      ]

    @callParent arguments
