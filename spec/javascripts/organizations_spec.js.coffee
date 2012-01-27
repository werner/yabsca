Ext.onReady ->
  describe 'Organizations', ->
    store = null
    controller = null

    beforeEach ->
      if not controller
        controller = Application.getController('Organizations')

      if not store
        store = controller.getStore('Organizations')

      expect(store).toBeTruthy()

      waitsFor ->
        not store.isLoading()
      ,'load never completed!', 4000

    it 'should have one root node', ->
      store.load()
      expect(store.getUpdatedRecords().length).toBe(1)

    it 'should show form', ->
      item = {}
      menu = Ext.create YABSCA.view.organization.Menu
      window = controller.addOrganization(item)
      expect(window).toBeTruthy()
      window.destroy() if window

    it 'should validates', ->
      item = {}
      window = controller.addOrganization(item)
      button = window.down 'button[action=save]'
      button.fireEvent 'click', button
      #if save is unsuccessful should return just the root
      expect(store.getUpdatedRecords().length).toBe(1)
      window.destroy() if window

    it 'should save an organization', ->
      item = {}
      window = controller.addOrganization(item)
      button = window.down 'button[action=save]'
      button.fireEvent 'click', button
      window.down('form').loadRecord
        data:
          name: 'Testing'
      #this fails, I still got to know why
      expect(store.getUpdatedRecords().length).toBe(2)
      window.destroy() if window
