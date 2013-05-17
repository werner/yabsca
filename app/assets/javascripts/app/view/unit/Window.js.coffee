Ext.define 'YABSCA.view.unit.Window',
  extend: 'Ext.window.Window'
  alias: 'widget.unit_window'
  height: 250
  width: 400
  closeAction: 'hide'
  title: 'Units'
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
        xtype: 'unit_grid'
      ,
        xtype: 'unit_form'
      ]

    @callParent arguments
