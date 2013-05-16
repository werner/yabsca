Ext.define 'YABSCA.view.measure.Chart',
  extend: 'Ext.window.Window'
  alias: 'widget.measure_chart'
  requires: ['Ext.form.Panel', 'Ext.chart.*']
  height: 300
  width: 400
  closeAction: 'hide'
  title: 'Chart'
  layout: 'fit'
  close: 'Close'
  title_period: 'Period'
  title_achieved: 'achieved'
  initComponent: ->
    @buttons = [
      text: @close
      iconCls: 'close'
      scope: this
      handler: @destroy
    ]

    @items = [
      xtype: 'chart'
      width: 400
      height: 300
      store: 'MeasureCharts'
      theme: 'Base'
      background:
        gradient:
          id: 'backgroundGradient'
          angle: 45
          stops:
            0:
              color: '#ffffff'
            100:
              color: '#eaf1f8'
      axes: [
        title: @title_achieved
        type: 'Numeric'
        position: 'left'
        fields: ['achieved', 'goal']
        minimum: 0
      ,
        title: @title_period
        type: 'Category'
        position: 'bottom'
        fields: ['period']
      ]
      series: [
        type: 'column'
        axis: 'bottom'
        xField: 'period'
        yField: 'achieved'
      ,
        type: 'line'
        axis: 'bottom'
        xField: 'period'
        yField: 'goal'
      ]
    ]

    @callParent arguments
