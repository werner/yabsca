var responsible = new Object();

responsible.id=0;
responsible.url=""
responsible.method=""
responsible.params=""

responsible.proxy=new Ext.data.HttpProxy({url:"/responsibles",method:"GET"});

responsible.reader=new Ext.data.JsonReader({
    idProperty: "id",
    root: "data",
    totalProperty: "results",
    fields:[{name:"id"},{name:"name"}]
});

responsible.store=new Ext.data.Store({
    proxy:responsible.proxy,
    reader:responsible.reader,
    autoSave: true
});

responsible.store.load();

responsible.grid=new Ext.grid.EditorGridPanel({
    store:responsible.store,
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
            responsible.id = g.store.getAt(index).id;
            responsible.url="/responsibles/"+responsible.id;
            responsible.method="PUT";
        },
        afterEdit: function(e){
            Ext.Ajax.request({
                url:responsible.url,
                method:responsible.method,
                params:{"responsible[name]": e.value, id:responsible.id},
                success:function(){
                    responsible.store.reload();
                }
            });
        }
    }
});

responsible.win=new Ext.Window({
    layout:"fit",
    width:400,
    height:200,
    closeAction:"hide",
    plain: true,
    items:[responsible.grid],
    buttons: [{
        text:'New Responsible',
        iconCls:'new',
        handler: function(){
            var u = new responsible.grid.store.recordType({name:''});
            responsible.id=0;
            responsible.url="/responsibles/create";
            responsible.method="POST";
            responsible.grid.stopEditing();
            responsible.grid.store.insert(0,u);
            responsible.grid.startEditing(0,1);
        }
    },{
        text:"Delete Responsible",
        iconCls:"del",
        handler: function(){
            Ext.Msg.show({
               title:'Delete',
               msg: 'Are you sure you want to delete it?',
               buttons: Ext.Msg.YESNO,
               fn: function(btn){
                   if (btn=='yes'){
                       Ext.Ajax.request({
                           url:"/responsibles/"+responsible.id,
                           method:"DELETE",
                           success:function(){
                                var index = responsible.grid.getSelectionModel().getSelectedCell();
                                if (!index)
                                    return false;
                                var rec = responsible.grid.store.getAt(index[0]);
                                responsible.grid.store.remove(rec);
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
            responsible.win.hide();
        }
    }]
});