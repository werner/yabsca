Ext.define 'YABSCA.store.Units',
  extend: 'Ext.data.Store'
  model: 'YABSCA.model.Unit'
  autoLoad: true
  proxy:
    type: 'ajax'
    url: '/units.json'
    reader:
      type: 'json'
      root: 'data'
