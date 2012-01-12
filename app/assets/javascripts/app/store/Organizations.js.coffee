Ext.define 'YABSCA.store.Organizations',
  extend: 'Ext.data.TreeStore'
  model: 'Organization'
  autoLoad: true
  proxy:
    type: 'ajax'
    url: '/organizations.json'
    root:
      nodeType: 'async'
      text: 'Organizations'
      draggable: false
      iconCls: 'orgs'
      id: 'src:root'
      iddb: 0
    reader:
      type: 'json'
      root: 'data'
