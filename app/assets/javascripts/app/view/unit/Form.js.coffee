Ext.define 'YABSCA.view.unit.Form',
  extend: 'Ext.form.Panel'
  alias: 'widget.unit_form'
  initComponent: ->
    Ext.apply this,
      bodyStyle: 'padding: 15px'
      labelWidth: 75
      defaults:
        width: 330
      items: [
        xtype: 'hiddenfield'
        name: 'id'
      ,
        xtype: 'textfield'
        name: 'name'
        fieldLabel: 'Name'
        allowBlank: false
      ]
      buttons: [
        text: 'Save'
        iconCls: 'save'
        action: 'save'
      ,
        text: 'Back'
        iconCls: 'back'
        action: 'back'
      ]

    @callParent arguments
