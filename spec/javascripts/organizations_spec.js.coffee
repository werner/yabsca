Ext.onReady ->
  describe 'Organizations', ->
    store = null
    controller = null

    beforeEach ->
      if not controller
        controller = Application.getController('Organizations')
        console.log controller

      if not store
        store = controller.getStore('Organizations')

      expect(store).toBeTruthy()

      waitsFor ->
        not store.isLoading()
      ,'load never completed!', 4000

    it 'should have one root node', ->
      store.load()
      expect(store.getUpdatedRecords().length).toBe(1)

    it 'should open the organizations window', ->
      form = Ext.create YABSCA.view.organization.Form

      expect(form).toBeTruthy()
      if form
        form.destroy()
