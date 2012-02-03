Ext.define 'YABSCA.view.user.Form',
  extend: 'Ext.form.Panel'
  alias: 'widget.user_form'
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
        name: 'login'
        fieldLabel: 'Login'
        allowBlank: false
      ,
        xtype: 'textfield'
        name: 'password'
        fieldLabel: 'Password'
        inputType: 'password'
        allowBlank: false
      ,
        xtype: 'textfield'
        name: 'password_confirmation'
        fieldLabel: 'Password Confirmation'
        inputType: 'password'
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
