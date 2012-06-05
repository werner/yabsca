Ext.define 'YABSCA.store.MeasureCharts',
  extend: 'Ext.data.Store'
  model: 'YABSCA.model.MeasureChart'
  proxy:
    type: 'ajax'
    url: '/measures/measure_charts.json'
    reader:
      type: 'json'
      root: 'data'
