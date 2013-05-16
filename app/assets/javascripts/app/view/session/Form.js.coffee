Ext.define 'YABSCA.view.session.Form',
  extend: 'Ext.form.Panel'
  alias: 'widget.session_form'
  login: 'Login'
  password: 'Password'
  login_button: 'login'
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
        action: 'login'
        fieldLabel: @login
        allowBlank: false
      ,
        xtype: 'textfield'
        name: 'password'
        action: 'password'
        fieldLabel: @password
        inputType: 'password'
        allowBlank: false
        enableKeyEvents: true
      ]
      buttons: [
        text: @login_button
        iconCls: 'login'
        action: 'login'
      ]

    @callParent arguments

