Ext.Loader.setPath 'Ext', './assets/ext/src'
Ext.onReady ->
  login = ->
    form.getForm().submit
      method: 'POST'
      success: (response) ->
        window.location = '/'

  @form = Ext.widget 'form',
    itemId: 'session_form'
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
      listeners:
        keyup:
          element: 'el'
          fn: (text, e, eOpts) ->
            login() if text.getCharCode() is Ext.EventObject.ENTER
    ]
    buttons: [
      text: 'Log In'
      iconCls: 'login'
      action: 'login'
      handler: ->
        login()
    ]

  win = Ext.widget 'window',
    layout:'fit'
    title: 'Log In'
    width:320
    height:170
    closable: false
    resizable: false
    plain: true
    border: false
    items: [form]

  win.show()
    
