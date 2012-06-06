Ext.define 'YABSCA.view.measure.Chart',
  extend: 'Ext.window.Window'
  alias: 'widget.measure_chart'
  requires: ['Ext.form.Panel', 'Ext.chart.*']
  height: 300
  width: 400
  closeAction: 'hide'
  title: 'Chart'
  layout: 'fit'
  initComponent: ->
    @buttons = [
      text: 'Close'
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
        title: 'Achieved'
        type: 'Numeric'
        position: 'left'
        fields: ['achieved', 'goal']
        minimum: 0
      ,
        title: 'Period'
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
