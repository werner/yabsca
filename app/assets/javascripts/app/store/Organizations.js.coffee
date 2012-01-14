Ext.define 'YABSCA.store.Organizations',
  extend: 'Ext.data.TreeStore'
  model: 'Tree'
  autoLoad: true
  proxy:
    type: 'ajax'
    url: '/organizations.json'
    reader:
      type: 'json'
      root: 'data'
