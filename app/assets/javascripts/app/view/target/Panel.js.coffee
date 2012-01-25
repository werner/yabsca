Ext.define 'YABSCA.view.target.Panel',
  extend: 'Ext.panel.Panel'
  alias: 'widget.target_panel'
  title: 'Targets'
  layout: 'card'
  initComponent: ->
    Ext.apply this,
      items: [
        xtype: 'target_grid'
      ,
        xtype: 'target_form'
      ]

    @callParent arguments
