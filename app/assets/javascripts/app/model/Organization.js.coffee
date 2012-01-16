Ext.define 'YABSCA.model.Organization',
  extend: 'Ext.data.Model'
  fields: ['id', 'organization_id', 'name', 'vision', 'goal', 'description']
  validations: [
    type: 'presence'
    field: 'name'
  ]
  proxy:
    type: 'rest'
    url: '/organizations'
