Ext.define 'YABSCA.store.Responsibles',
  extend: 'Ext.data.Store'
  model: 'YABSCA.model.Responsible'
  autoLoad: true
  proxy:
    type: 'ajax'
    url: '/responsibles.json'
    reader:
      type: 'json'
      root: 'data'
