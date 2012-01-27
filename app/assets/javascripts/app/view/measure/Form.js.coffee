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
          xtype: 'combo'
          name: 'challenge'
          fieldLabel: 'Challenge'
          displayField: 'name'
          valueField: 'id'
          store: new Ext.data.ArrayStore
            fields: ["id", "name"]
            data: [
              [1, "Increasing"]
              [2, "Decreasing"]
            ]
        ,
          xtype: 'numberfield'
          name: 'excellent'
          fieldLabel: 'Excellent'
        ,
          xtype: 'numberfield'
          name: 'alert'
          fieldLabel: 'Alert'
        ,
          xtype: 'combo'
          name: 'frecuency'
          fieldLabel: 'Frecuency'
          displayField: 'name'
          valueField: 'id'
          store: new Ext.data.ArrayStore
            fields: ["id", "name"]
            data: [[1,"Daily"],[6,"Weekly"],[5,"Monthly"],[2,"Bimonthly"],
                    [3,"Three_monthly"],[4,"Four_monthly"],[7,"Yearly"]]
        ,
          xtype: 'datefield'
          name: 'period_from'
          fieldLabel: 'From'
          submitFormat: 'Y/m/d'
        ,
          xtype: 'datefield'
          name: 'period_to'
          fieldLabel: 'To'
          submitFormat: 'Y/m/d'
        ,
          xtype: 'textarea'
          name: 'formula'
          fieldLabel: 'Formula'
        ]
      ]

    @callParent arguments
