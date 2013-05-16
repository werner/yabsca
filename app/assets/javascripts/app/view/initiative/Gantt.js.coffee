Ext.define 'YABSCA.view.initiative.Gantt',
  extend: 'Ext.window.Window'
  alias: 'widget.initiative_gantt'
  height: 350
  width: 800
  closeAction: 'hide'
  title: 'Gantt'
  layout: 'fit'
  close: 'Close'
  initComponent: ->
    @buttons = [
      text: @close
      iconCls: 'close'
      scope: this
      handler: @destroy
    ]
    @items = [
      xtype: 'panel'
      id: 'panel_gantt'
      html: "<div class='gantt'></div>"
    ]

    @callParent arguments
