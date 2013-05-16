Ext.define 'YABSCA.view.Viewport',
  extend: 'Ext.Viewport'
  layout: 'fit'
  lang_title: 'Balanced ScoreCard Application'
  lang_settings: 'Settings'
  lang_units: 'Units'
  lang_resp: 'Responsibles'
  lang_users: 'Users'
  lang_log_out: 'Log Out'
  lang_org_strat: 'Organizations and Strategies'
  lang_persp_obj: 'Perspectives and Objectives'
  lang_initiative: 'Initiatives'
  lang_measure: 'Measures'
  lang_target: 'Targets'
  initComponent: ->
    me = this

    Ext.apply me,
      items: [
        xtype: 'panel'
        id: 'viewport'
        title: @lang_title
        layout: 'card'
        items: [
          xtype: 'panel'
          id: 'login_viewport'
          layout: 'anchor'
          items: [
            anchor: '30%'
            xtype: 'session_form'
          ]
        ,
          xtype: 'panel'
          layout: 'border'
          tbar: [
            xtype: 'button'
            text: @lang_settings
            iconCls: 'tools'
            width: 100
            menu:
              xtype: 'menu'
              items: [
                text: @lang_units
                iconCls: 'unit'
                action: 'units'
              ,
                text: @lang_resp
                iconCls: 'responsible'
                action: 'responsibles'
              ,
                text: @lang_users
                iconCls: 'user'
                action: 'users'
              ,
                text: @lang_log_out
                iconCls: 'exit'
                handler: ->
                  Ext.Ajax.request
                    url: '/logout'
                    method: 'DELETE'
                    success: (response) ->
                      window.location.href = "/" + location.href.split('/')[3]
              ]
          ]
          items: [
            region: 'west'
            width: 300
            layout: 'fit'
            border: false
            items:
              xtype: 'organization_tree'
              title: @lang_org_strat
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
                title: @lang_persp_obj
                flex: 1
              ,
                xtype: 'initiative_tree'
                region: 'center'
                title: @lang_initiative
                flex: 1
              ]
            ,
              region: 'center'
              layout: 'border'
              border: false
              items: [
                xtype: 'measure_tree'
                region: 'west'
                title: @lang_measure
                border: false
                flex: 1
              ,
                xtype: 'target_panel'
                region: 'center'
                title: @lang_target
                border: false
                flex: 1
              ]
            ]
          ]
        ]
        listeners:
          afterlayout: ->
            Ext.Ajax.request
              url: '/authorization'
              success: (response) ->
                result = Ext.JSON.decode(response.responseText)
                viewport = Ext.ComponentQuery.query('viewport')[0]
                layout = viewport.down('panel').getLayout()
                if result.success is true
                  layout.setActiveItem(1)
                else
                  layout.setActiveItem(0)
      ]

    me.callParent arguments
