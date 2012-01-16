Ext.define 'YABSCA.model.Strategy',
  extend: 'Ext.data.Model'
  fields: ['id', 'name', 'description', 'organization_id']
  validations: [
    type: 'presence'
    field: 'name'
  ]
  proxy:
    type: 'rest'
    url: '/strategies'
