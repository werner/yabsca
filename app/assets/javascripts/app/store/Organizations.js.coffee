Ext.define 'YABSCA.store.Organizations',
  extend: 'Ext.data.TreeStore'
  model: 'Tree'
  autoLoad: true
  root:
    text: 'Organizations'
    id: 'src:root'
    expanded: true
    draggable: false
    iconCls: 'orgs'
    iddb: 0
    node_id: 0
  proxy:
    type: 'ajax'
    url: '/organizations.json'
    reader:
      type: 'json'
      root: 'data'
