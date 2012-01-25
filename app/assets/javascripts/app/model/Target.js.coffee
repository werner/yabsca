Ext.define 'YABSCA.model.Target',
  extend: 'Ext.data.Model'
  fields: ['id', 'period', 'goal', 'achieved', 'measure_id']
  proxy:
    type: 'rest'
    url: '/targets'
