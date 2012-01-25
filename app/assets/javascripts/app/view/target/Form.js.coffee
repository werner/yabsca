Ext.define 'YABSCA.view.target.Form',
  extend: 'Ext.form.Panel'
  alias: 'widget.target_form'
  initComponent: ->

    Ext.apply this,
      bodyStyle: 'padding: 15px'
      labelWidth: 75
      defaults:
        width: 330
      items: [
        xtype: 'hiddenfield'
        name: 'id'
      ,
        xtype: 'hiddenfield'
        name: 'measure_id'
      ,
        xtype: 'combo'
        name: 'period'
        fieldLabel: 'Period'
        store: 'Periods'
        displayField: 'name'
        valueField: 'name'
      ,
        xtype: 'numberfield'
        name: 'goal'
        fieldLabel: 'Goal'
      ,
        xtype: 'numberfield'
        name: 'achieved'
        fieldLabel: 'Achieved'
      ]
      buttons: [
        text: 'Save'
        iconCls: 'save'
        action: 'save'
      ,
        text: 'Back'
        iconCls: 'back'
        action: 'back'
      ]

    @callParent arguments
