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
        tbar: [
          xtype: 'button'
          text: 'Settings'
          iconCls: 'tools'
          width: 100
          menu:
            xtype: 'menu'
            items: [
              text: 'Units'
              iconCls: 'unit'
              action: 'units'
            ,
              text: 'Responsibles'
              iconCls: 'responsible'
              action: 'responsibles'
            ]
        ]
        items: [
          region: 'west'
          width: 300
          layout: 'fit'
          border: false
          items:
            xtype: 'organization_tree'
            title: 'Organizations and Strategies'
            border: false
        ,
          region: 'center'
          width: 200
          layout: 'border'
          border: false
          split: true
          items: [
            region: 'north'
            layout: 'border'
            border: false
            height: 300
            items: [
              xtype: 'perspective_tree'
              region: 'west'
              title: 'Perspectives and Objectives'
              flex: 1
            ,
              xtype: 'initiative_tree'
              region: 'center'
              title: 'Initiatives'
              flex: 1
            ]
          ,
            region: 'center'
            layout: 'fit'
            border: false
            items:
              xtype: 'measure_tree'
              title: 'Measures'
          ]
        ]
      ]

    me.callParent arguments
