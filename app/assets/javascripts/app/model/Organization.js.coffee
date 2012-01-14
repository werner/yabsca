Ext.define 'YABSCA.model.Organization',
  extend: 'Ext.data.Model'
  fields: ['id', 'organization_id', 'name', 'vision', 'goal', 'description']
  proxy:
    type: 'rest'
    url: '/organizations'
