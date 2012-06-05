Ext.define 'YABSCA.view.session.Form',
  extend: 'Ext.form.Panel'
  alias: 'widget.session_form'
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
      ]
      buttons: [
        text: 'Login'
        iconCls: 'login'
        action: 'login'
      ]

    @callParent arguments

#Ext.Loader.setPath 'Ext', './assets/ext/src'
#Ext.onReady ->
#  login = ->
#    form.getForm().submit
#      method: 'POST'
#      success: (response) ->
#        window.location = '/'
#
#  @form = Ext.widget 'form',
#    itemId: 'session_form'
#    frame: true
#    url: '/login'
#    bodyStyle: 'padding: 15px'
#    width: 350
#    labelWidth: 75
#    items: [
#      xtype: 'hiddenfield'
#      name: 'id'
#    ,
#      xtype: 'textfield'
#      name: 'login'
#      fieldLabel: 'Login'
#      allowBlank: false
#    ,
#      xtype: 'textfield'
#      name: 'password'
#      fieldLabel: 'Password'
#      inputType: 'password'
#      allowBlank: false
#      listeners:
#        keyup:
#          element: 'el'
#          fn: (text, e, eOpts) ->
#            login() if text.getCharCode() is Ext.EventObject.ENTER
#    ]
#    buttons: [
#      text: 'Log In'
#      iconCls: 'login'
#      action: 'login'
#      handler: ->
#        login()
#    ]
#
#  win = Ext.widget 'window',
#    layout:'fit'
#    title: 'Log In'
#    width:320
#    height:170
#    closable: false
#    resizable: false
#    plain: true
#    border: false
#    items: [form]
#
#  win.show()
#    
