Ext.define 'YABSCA.store.Perspectives',
  extend: 'Ext.data.TreeStore'
  model: 'Tree'
  autoLoad: true
  root:
    text: 'Perspectives'
    id: 'src:root'
    expanded: true
    draggable: false
    iconCls: 'persp'
    iddb: 0
    node_id: 0
  proxy:
    type: 'ajax'
    url: '/perspectives.json'
    reader:
      type: 'json'
      root: 'data'
