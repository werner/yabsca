Ext.define 'YABSCA.view.measure.Form',
  extend: 'Ext.window.Window'
  alias: 'widget.measure_form'
  requires: ['Ext.form.Panel']
  height: 500
  width: 400
  closeAction: 'hide'
  title: 'Measure'
  layout: 'fit'
  save: 'Save'
  close: 'Close'
  code: 'Code'
  name: 'Nombre'
  description: 'Description'
  challenge: 'challenge'
  excellent: 'Excellent'
  alert: 'Alert'
  frecuency: 'Frecuency'
  from: 'From'
  to: 'To'
  unit: 'Unit'
  responsible: 'Responsible'
  initComponent: ->
    @buttons = [
      text: @save
      iconCls: 'save'
      action: 'save'
    ,
      text: @close
      iconCls: 'close'
      scope: this
      handler: @destroy
    ]

    @items = [
      xtype: 'form'
      padding: '5 5 0 5'
      defaults:
        anchor: '100%'
        padding: '5'
      border: false
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
        name: 'code'
        fieldLabel: @code
        allowBlank: false
      ,
        name: 'name'
        fieldLabel: @name
        allowBlank: false
      ,
        xtype: 'textarea'
        name: 'description'
        fieldLabel: @description
      ,
        xtype: 'combo'
        name: 'challenge'
        fieldLabel: @challenge
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
        fieldLabel: @excellent
      ,
        xtype: 'numberfield'
        name: 'alert'
        fieldLabel: @alert
      ,
        xtype: 'combo'
        name: 'frecuency'
        fieldLabel: @frecuency
        displayField: 'name'
        valueField: 'id'
        store: new Ext.data.ArrayStore
          fields: ["id", "name"]
          data: [[1,"Daily"],[6,"Weekly"],[5,"Monthly"],[2,"Bimonthly"],
                  [3,"Three_monthly"],[4,"Four_monthly"],[7,"Yearly"]]
      ,
        xtype: 'datefield'
        name: 'period_from'
        fieldLabel: @from
        submitFormat: 'Y/m/d'
      ,
        xtype: 'datefield'
        name: 'period_to'
        fieldLabel: @to
        submitFormat: 'Y/m/d'
      ,
        xtype: 'combo'
        name: 'unit_id'
        fieldLabel: @unit
        displayField: 'name'
        valueField: 'id'
        store: 'Units'
      ,
        xtype: 'combo'
        name: 'responsible_id'
        fieldLabel: @responsible
        displayField: 'name'
        valueField: 'id'
        store: 'Responsibles'
      ,
        xtype: 'hiddenfield'
        name: 'formula'
      ]
    ]

    @callParent arguments
