var unit = new Object();

unit.id=0
unit.parent_id=0;
unit.url=""
unit.method=""
unit.params=""

unit.proxy=new Ext.data.HttpProxy({url: "/units", method:"GET"});

unit.reader=new Ext.data.JsonReader({
    idProperty: "id",
    root: "data",
    totalProperty: "results",
    fields:[{name: 'id'},{name:"name"}]
});

unit.store=new Ext.data.Store({
    proxy:unit.proxy,
    reader:unit.reader,
    autoSave: true
});

unit.store.load();

unit.grid=new Ext.grid.EditorGridPanel({
    store:unit.store,
    clicksToEdit: 2,
    width:400,
    height:200,
    columns:[{header: "ID", width: 40, sortable: true, dataIndex: 'id', hidden:true},
             {header: "Name",
              width: 300,
              dataIndex: 'name',
              sortable: true,
              editor: new Ext.form.TextField({
                    allowBlank: false
                })
             }],
    listeners:{
        rowclick: function(g, index, ev) {
            unit.id = g.store.getAt(index).id;
            unit.url="/units/"+unit.id;
            unit.method="PUT";
        },
        afterEdit: function(e){
            Ext.Ajax.request({
                url:unit.url,
                method:unit.method,
                params:{"unit[name]": e.value, id:unit.id},
                success:function(){
                    unit.store.reload();
                }
            });
        }
    }
});

unit.win=new Ext.Window({
    layout:"fit",
    width:400,
    height:200,
    closeAction:"hide",
    plain: true,
    items:[unit.grid],
    buttons: [{
        text:'New Unit',
        iconCls:'new',
        handler: function(){
            var u = new unit.grid.store.recordType({name:''});
            unit.id=0;
            unit.url="/units/create";
            unit.method="POST";
            unit.grid.stopEditing();
            unit.grid.store.insert(0,u);
            unit.grid.startEditing(0,1);
        }
    },{
        text:"Delete Unit",
        iconCls:"del",
        handler: function(){
    Ext.Msg.show({
       title:'Delete',
       msg: 'Are you sure you want to delete it?',
       buttons: Ext.Msg.YESNO,
       fn: function(btn){
           if (btn=='yes'){
               Ext.Ajax.request({
                   url:"/units/"+unit.id,
                   method:"DELETE",
                   success:function(){
                        var index = unit.grid.getSelectionModel().getSelectedCell();
                        if (!index)
                            return false;
                        var rec = unit.grid.store.getAt(index[0]);
                        unit.grid.store.remove(rec);
                   }
               });
           }
       },
       animEl: 'elId',
       icon: Ext.MessageBox.QUESTION
    });

        }
    },{
        text:'Close',
        iconCls:'close',
        handler:function(){
            unit.win.hide();
        }
    }]
});