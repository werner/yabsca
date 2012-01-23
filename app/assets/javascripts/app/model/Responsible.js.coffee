Ext.define 'YABSCA.model.Responsible',
  extend: 'Ext.data.Model'
  fields: ['id', 'name']
  validations: [
    type: 'presence'
    field: 'name'
  ]
  proxy:
    type: 'rest'
    url: '/responsibles'
