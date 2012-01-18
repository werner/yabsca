Ext.onReady ->
  describe 'Basic Assumptions', ->
    it 'has Extjs loaded', ->
      expect(Ext).toBeDefined()
      expect(Ext.getVersion()).toBeTruthy()
      expect(Ext.getVersion().major).toEqual(4)

    it 'has Loaded YABSCA namespace', ->
      expect(YABSCA).toBeDefined()
