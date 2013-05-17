Ext.define 'YABSCA.view.user.Window',
  extend: 'Ext.window.Window'
  alias: 'widget.user_window'
  height: 250
  width: 400
  closeAction: 'hide'
  title: 'Users'
  layout: 'card'
  close: 'Close'
  initComponent: ->
    Ext.apply this,
      buttons: [
        text: @close
        iconCls: 'close'
        scope: this
        handler: @destroy
      ]
      items: [
        xtype: 'user_grid'
      ,
        xtype: 'user_form'
      ]

    @callParent arguments
