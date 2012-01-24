Ext.define 'YABSCA.model.Initiative',
  extend: 'Ext.data.Model'
  fields: ['id', 'code', 'name', 'completed', 'beginning', 'end', 'objective_id',
           'initiative_id', 'responsible_id']
  validations: [
    type: 'presence'
    field: 'name'
  ]
  proxy:
    type: 'rest'
    url: '/initiatives'
