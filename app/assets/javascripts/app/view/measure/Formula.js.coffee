Ext.define 'YABSCA.view.measure.Formula',
  extend: 'Ext.window.Window'
  alias: 'widget.measure_formula'
  requires: ['Ext.form.Panel']
  height: 300
  width: 400
  closeAction: 'hide'
  title: 'Measure'
  layout: 'fit'
  initComponent: ->
    Ext.apply this,
      buttons: [
        text: 'Save'
        iconCls: 'save'
        action: 'save'
      ,
        text: 'Close'
        iconCls: 'close'
        scope: this
        handler: @destroy
      ]
      items: [
        xtype: 'form'
        bodyStyle: 'padding: 15px'
        defaults:
          width: 350
        defaultType: 'textarea'
        items: [
          name: 'formula'
          fieldLabel: 'Formula'
          height: 200
        ,
          xtype: 'hiddenfield'
          name: 'id'
        ,
          xtype: 'hiddenfield'
          name: 'node_id'
        ,
          xtype: 'hiddenfield'
          name: 'code'
        ,
          xtype: 'hiddenfield'
          name: 'name'
        ,
          xtype: 'hiddenfield'
          name: 'objective_ids'
          value: 0
        ,
          xtype: 'hiddenfield'
          name: 'description'
        ,
          xtype: 'hiddenfield'
          name: 'challenge'
        ,
          xtype: 'hiddenfield'
          name: 'excellent'
        ,
          xtype: 'hiddenfield'
          name: 'alert'
        ,
          xtype: 'hiddenfield'
          name: 'frecuency'
        ,
          xtype: 'hiddenfield'
          name: 'period_from'
        ,
          xtype: 'hiddenfield'
          name: 'period_to'
        ,
          xtype: 'hiddenfield'
          name: 'unit_id'
        ,
          xtype: 'hiddenfield'
          name: 'responsible_id'
        ]
      ]

    @callParent arguments
