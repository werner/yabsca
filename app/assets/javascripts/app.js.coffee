Ext.Loader.setPath 'Ext', './assets/ext/src'
Ext.application
  name: 'YABSCA'
  appFolder: 'assets/app'
  requires: ['Ext.util.Cookies']
  controllers: ['Organizations', 'Strategies', 'Perspectives', 'Objectives',
                'Measures', 'Menu', 'Units', 'Responsibles', 'Initiatives',
                'Targets', 'Users', 'Sessions']
  autoCreateViewport: true
