Ext.define 'YABSCA.store.Organizations',
  extend: 'Ext.data.TreeStore'
  model: 'Tree'
  root:
    text: 'Organizaciones'
    id: 'src:root'
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
