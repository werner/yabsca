Ext.define 'YABSCA.view.measure.Form',
  extend: 'Ext.window.Window'
  alias: 'widget.measure_form'
  requires: ['Ext.form.Panel']
  height: 450
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
        labelWidth: 75
        defaults:
          width: 330
        defaultType: 'textfield'
        items: [
          xtype: 'hiddenfield'
          name: 'id'
        ,
          xtype: 'hiddenfield'
          name: 'node_id'
        ,
          xtype: 'hiddenfield'
          name: 'objective_ids'
          value: 0
        ,
          xtype: 'hiddenfield'
          name: 'unit_id'
          value: 0
        ,
          xtype: 'hiddenfield'
          name: 'responsible_id'
          value: 0
        ,
          name: 'code'
          fieldLabel: 'Code'
          allowBlank: false
        ,
          name: 'name'
          fieldLabel: 'Name'
          allowBlank: false
        ,
          xtype: 'textarea'
          name: 'description'
          fieldLabel: 'Description'
        ,
          xtype: 'numberfield'
          name: 'challenge'
          fieldLabel: 'Challenge'
        ,
          xtype: 'numberfield'
          name: 'excellent'
          fieldLabel: 'Excellent'
        ,
          xtype: 'numberfield'
          name: 'alert'
          fieldLabel: 'Alert'
        ,
          xtype: 'numberfield'
          name: 'frecuency'
          fieldLabel: 'Frecuency'
        ,
          xtype: 'datefield'
          name: 'period_from'
          fieldLabel: 'From'
        ,
          xtype: 'datefield'
          name: 'period_to'
          fieldLabel: 'To'
        ,
          xtype: 'textarea'
          name: 'formula'
          fieldLabel: 'Formula'
        ]
      ]

    @callParent arguments
