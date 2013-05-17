Ext.define 'YABSCA.view.user.Form',
  extend: 'Ext.form.Panel'
  alias: 'widget.user_form'
  save: 'Save'
  login: 'Login'
  password: 'Password'
  password_confirmation: 'Password Confirmation'
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
        name: 'login'
        fieldLabel: @login
        allowBlank: false
      ,
        xtype: 'textfield'
        name: 'password'
        fieldLabel: @password
        inputType: 'password'
        allowBlank: false
      ,
        xtype: 'textfield'
        name: 'password_confirmation'
        fieldLabel: @password_confirmation
        inputType: 'password'
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
