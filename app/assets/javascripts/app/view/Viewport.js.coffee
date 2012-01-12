Ext.define 'YABSCA.view.Viewport',
  extend: 'Ext.Viewport'
  layout: 'fit'
  initComponent: ->
    me = this

    Ext.apply me,
      items: [
        xtype: 'panel'
        id: 'viewport'
        title: 'Balanced ScoreCard Application'
        layout: 'border'
        items: [
          region: 'north'
          xtype: 'box'
          height: 27
        ,
          region: 'west'
          title: 'Organizations'
          width: 300
          layout: 'fit'
          items: [
            xtype: 'organization_tree'
          ]
        ,
          region: 'center'
          width: 200
        ]
      ]

    me.callParent arguments
