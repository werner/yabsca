Ext.define 'YABSCA.store.Targets',
  extend: 'Ext.data.Store'
  model: 'YABSCA.model.Target'
  autoLoad: true
  proxy:
    type: 'ajax'
    url: '/targets.json'
    reader:
      type: 'json'
      root: 'data'
