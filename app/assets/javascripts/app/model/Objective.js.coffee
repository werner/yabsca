Ext.define 'YABSCA.model.Objective',
  extend: 'Ext.data.Model'
  fields: ['id', 'name', 'perspective_id', 'objective_id']
  validations: [
    type: 'presence'
    field: 'name'
  ]
  proxy:
    type: 'rest'
    url: '/objectives'
