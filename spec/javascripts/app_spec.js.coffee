#to load the ext sources
Ext.Loader.setPath 'Ext', './assets/ext/src'
Ext.require 'Ext.app.Application'

#this way I can use variables like YABSCA out of the scope
root = exports ? this

root.Application = null

Ext.onReady ->
  root.Application = Ext.create 'Ext.app.Application',
    name: 'YABSCA'
    appFolder: 'assets/app'
    controllers: ['Organizations', 'Strategies', 'Perspectives', 'Objectives']
    launch: ->
      jasmine.getEnv().addReporter(new jasmine.TrivialReporter())
      jasmine.getEnv().execute()
