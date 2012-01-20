Ext.define 'YABSCA.store.Measures',
  extend: 'Ext.data.TreeStore'
  model: 'Tree'
  autoLoad: true
  root:
    text: 'Measures'
    id: 'src:root'
    expanded: true
    draggable: false
    iconCls: 'measure'
    iddb: 0
    node_id: 0
  proxy:
    type: 'ajax'
    url: '/measures.json'
    reader:
      type: 'json'
      root: 'data'
