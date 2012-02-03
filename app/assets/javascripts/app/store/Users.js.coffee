Ext.define 'YABSCA.store.Users',
  extend: 'Ext.data.Store'
  model: 'YABSCA.model.User'
  autoLoad: true
  proxy:
    type: 'ajax'
    url: '/users.json'
    reader:
      type: 'json'
      root: 'data'
