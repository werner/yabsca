Ext.define 'YABSCA.store.Periods',
  extend: 'Ext.data.Store'
  model: 'YABSCA.model.Period'
  proxy:
    type: 'ajax'
    url: '/measures/get_periods.json'
    reader:
      type: 'json'
      root: 'data'
