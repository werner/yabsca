Ext.define 'YABSCA.model.User',
  extend: 'Ext.data.Model'
  fields: ['id', 'login', 'password', 'password_confirmation']
  validations: [
    type: 'presence'
    field: 'login'
  ]
  proxy:
    type: 'rest'
    url: '/users'
