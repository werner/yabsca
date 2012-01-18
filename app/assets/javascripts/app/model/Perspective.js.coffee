Ext.define 'YABSCA.model.Perspective',
  extend: 'Ext.data.Model'
  fields: ['id', 'name', 'strategy_id']
  validations: [
    type: 'presence'
    field: 'name'
  ]
  proxy:
    type: 'rest'
    url: '/perspectives'
