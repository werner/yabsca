Ext.define 'YABSCA.model.Unit',
  extend: 'Ext.data.Model'
  fields: ['id', 'name']
  validations: [
    type: 'presence'
    field: 'name'
  ]
  proxy:
    type: 'rest'
    url: '/units'
