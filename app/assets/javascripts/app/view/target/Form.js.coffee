Ext.define 'YABSCA.view.target.Form',
  extend: 'Ext.form.Panel'
  alias: 'widget.target_form'
  save: 'Save'
  period: 'Period'
  goal: 'Goal'
  achieved: 'Achieved'
  back: 'Back'
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
        fieldLabel: @period
        store: 'Periods'
        displayField: 'name'
        valueField: 'name'
      ,
        xtype: 'numberfield'
        name: 'goal'
        fieldLabel: @goal
      ,
        xtype: 'numberfield'
        name: 'achieved'
        fieldLabel: @achieved
      ]
      buttons: [
        text: @save
        iconCls: 'save'
        action: 'save'
      ,
        text: @back
        iconCls: 'back'
        action: 'back'
      ]

    @callParent arguments
