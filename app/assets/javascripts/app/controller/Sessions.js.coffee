Ext.define 'YABSCA.controller.Sessions',
  extend: 'Ext.app.Controller'
  views: ['session.Form']
  init: ->
    @control(
      'session_form button[action=login]':
        click: @login
      'session_form':
        afterrender: @authenticate
      'session_form textfield[action=password]':
        keyup: @loginByEnter
    )
  login: (button) ->
    form = Ext.ComponentQuery.query('session_form')[0]
    viewport = Ext.ComponentQuery.query('viewport')[0].down('panel')

    Ext.Ajax.request
      url: '/login'
      params:
        login: form.down('textfield[name=login]').value
        password: form.down('textfield[name=password]').value
        'X-CSRF-Token': YABSCA.csrfToken
      success: (response) ->
        result = Ext.JSON.decode(response.responseText)
        if result.success is true
          viewport.getLayout().setActiveItem 1
        else
          Ext.MessageBox.alert "Login", "Invalid Login or Password"
  loginByEnter: (text, e, eOpts) ->
    @login() if e.getCharCode() is Ext.EventObject.ENTER
  authenticate: ->
    try
      YABSCA.csrfToken = Ext.select("meta[name='csrf-token']").elements[0].getAttribute('content')
     
      # Ensure the Rails CSRF token is always sent
      Ext.Ajax.on('beforerequest', (o,r) ->
        r.headers = Ext.apply(
          'Accept': 'application/json'
          'X-CSRF-Token': YABSCA.csrfToken
        , r.headers || {})
      )
    catch e
      console.log 'CSRF protection appears to be disabled'
