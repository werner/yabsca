Ext.define 'YABSCA.view.responsible.Window',
  extend: 'Ext.window.Window'
  alias: 'widget.responsible_window'
  height: 250
  width: 400
  closeAction: 'hide'
  title: 'Responsibles'
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
        xtype: 'responsible_grid'
      ,
        xtype: 'responsible_form'
      ]

    @callParent arguments
