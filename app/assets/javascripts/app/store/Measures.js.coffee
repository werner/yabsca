Ext.define 'YABSCA.store.Measures',
  extend: 'Ext.data.TreeStore'
  model: 'Tree'
  root:
    text: 'Measures'
    id: 'src:root'
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
