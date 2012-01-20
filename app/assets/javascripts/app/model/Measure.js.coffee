Ext.define 'YABSCA.model.Measure',
  extend: 'Ext.data.Model'
  fields: ['id', 'code', 'name', 'description', 'challenge', 'excellent', 'objective_ids',
           'alert', 'frecuency', 'period_from', 'period_to', 'unit_id', 'responsible_id', 'formula']
  validations: [
    type: 'presence'
    field: 'name'
  ]
  proxy:
    type: 'rest'
    url: '/measures'
