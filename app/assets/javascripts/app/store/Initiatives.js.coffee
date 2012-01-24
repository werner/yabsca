Ext.define 'YABSCA.store.Initiatives',
  extend: 'Ext.data.TreeStore'
  model: 'Tree'
  autoLoad: true
  root:
    text: 'Initiatives'
    id: 'src:root'
    expanded: true
    draggable: false
    iconCls: 'initiative'
    iddb: 0
    node_id: 0
  proxy:
    type: 'ajax'
    url: '/initiatives.json'
    reader:
      type: 'json'
      root: 'data'
