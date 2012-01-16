Ext.define 'YABSCA.controller.Organizations',
  extend: 'Ext.app.Controller'
  stores: ['Organizations']
  models: ['Organization', 'Tree']
  views: ['organization.Tree', 'organization.Menu', 'organization.Form']
  requires: ['YABSCA.lib.StandardActions']
  contextMenu: 'YABSCA.view.organization.Menu'
  mainForm: 'YABSCA.view.organization.Form'
  mainModel: 'YABSCA.model.Organization'
  mainStore: ->
    @getOrganizationsStore()
  init: ->
    @control(
      'treepanel':
        itemcontextmenu: YABSCA.lib.StandardActions.showMenu
      'menu':
        hide: YABSCA.lib.StandardActions.closeMenu
      'menu component[action=new]':
        click: YABSCA.lib.StandardActions.addRecord
      'menu component[action=edit]':
        click: YABSCA.lib.StandardActions.editRecord
      'menu component[action=delete]':
        click: YABSCA.lib.StandardActions.deleteRecord
      'window button[action=save]':
        click: YABSCA.lib.StandardActions.saveRecord
    )
