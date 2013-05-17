Ext.define 'YABSCA.view.responsible.Form',
  extend: 'Ext.form.Panel'
  alias: 'widget.responsible_form'
  title: 'Responsible'
  save: 'Save'
  name: 'Name'
  back: 'Back'
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
        fieldLabel: @name
        allowBlank: false
      ]
      buttons: [
        text: @save
        iconCls: 'save'
        action: 'save'
      ,
        text: @back
        iconCls: 'back'
        action: 'back'
      ]

    @callParent arguments
