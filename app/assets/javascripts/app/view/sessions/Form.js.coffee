Ext.Loader.setPath 'Ext', './assets/ext/src'
Ext.onReady ->
  form = Ext.widget 'form',
    frame: true
    url: '/login'
    bodyStyle: 'padding: 15px'
    width: 350
    labelWidth: 75
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
    ]
    buttons: [
      text: 'Log In'
      iconCls: 'login'
      handler: ->
        this.up('form').getForm().submit
          method: 'POST'
          success: (response) ->
            window.location = '/'
    ]

  win = Ext.widget 'window',
    layout:'fit'
    title: 'Log In'
    width:300
    height:150
    closable: false
    resizable: false
    plain: true
    border: false
    items: [form]

  win.show()
    
