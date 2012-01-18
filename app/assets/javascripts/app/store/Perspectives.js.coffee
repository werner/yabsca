Ext.define 'YABSCA.store.Perspectives',
  extend: 'Ext.data.TreeStore'
  model: 'Tree'
  autoLoad: true
  proxy:
    type: 'ajax'
    url: '/perspectives.json'
    reader:
      type: 'json'
      root: 'data'
