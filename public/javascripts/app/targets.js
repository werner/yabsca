var target = new Object();

target.id=0;
target.url="";
target.method="";
target.record_index=undefined;

target.proxy=new Ext.data.HttpProxy({url:"/targets",method:"GET"});

target.reader=new Ext.data.JsonReader({
    idProperty: "id",
    root: "data",
    totalProperty: "results",
    fields:[{name:"id"},{name:"period"},{name:"goal"},{name:"achieved"}]
});

target.store=new Ext.data.Store({
    proxy:target.proxy,
    reader:target.reader,
    autoSave: true
});

target.toolBar=new Ext.Toolbar({
    items:[{
        text:"New",
        iconCls:"new",
        handler:function(){
            if (measure.id>0){
                var u = new target.grid.store.recordType({period:"",goal:"",achieved:""});
                target.id=0;
                target.url="/targets/create";
                target.method="POST";
                target.grid.stopEditing();
                target.grid.store.insert(0,u);
                target.grid.startEditing(0,1);
            }else{
                Ext.Msg.alert("Error","You must select a measure");
            }
        }
    },{
        text:"Save",
        iconCls:"saving",
        handler:function(){
            var records=target.grid.store.getModifiedRecords();
            for (var i=0;i<records.length;i++){
                if (records[i].data.id==undefined){
                    Ext.Ajax.request({
                        url:"/targets/create",
                        method:"POST",
                        params:{"target[measure_id]":measure.id,
                                "target[period]":records[i].data.period,
                                "target[goal]":records[i].data.goal,
                                "target[achieved]":records[i].data.achieved}
                    });
                }else{
                    Ext.Ajax.request({
                        url:"/targets/"+records[i].data.id,
                        method:"PUT",
                        params:{"target[period]":records[i].data.period,
                                "target[goal]":records[i].data.goal,
                                "target[achieved]":records[i].data.achieved}
                    });
                }
            }
            target.grid.store.commitChanges();
        }
    },{
        text:"Delete",
        iconCls:"del",
        handler:function(){
            if (target.id>0){
                Ext.Msg.show({
                   title:"Delete",
                   msg: "Are you sure you want to delete it?",
                   buttons: Ext.Msg.YESNO,
                   fn: function(btn){
                       if (btn=="yes"){
                           Ext.Ajax.request({
                               url:"/targets/"+target.id,
                               method:"DELETE",
                               success:function(){
                                   var u=target.grid.store.getAt(target.record_index);
                                   target.grid.store.remove(u);
                                   target.grid.store.reload();
                               }
                           });
                       }
                   },
                   icon: Ext.MessageBox.QUESTION
                });
            }else{
                Ext.Msg.alert("Error","You must select a target");
            }
        }
    }]
});

target.frec_proxy=new Ext.data.HttpProxy({url:"/get_targets",method:"GET"});

target.frec_reader=new Ext.data.JsonReader({
    idProperty: "name",
    root: "data",
    fields:[{name:"name"}]
});

target.frec_store=new Ext.data.Store({
    proxy:target.frec_proxy,
    reader:target.frec_reader
});

target.grid=new Ext.grid.EditorGridPanel({
    region: "center",
    title:"Targets",
    store:target.store,
    clicksToEdit: 2,
    tbar:[target.toolBar],
    columns:[{header:"id",dataIndex:"id", hidden:true},
             {header:"Period", dataIndex:"period",width:150,
                 editor: new Ext.form.ComboBox({
                    id: "target_period",
                    name: "target[period]",
                    store:  target.frec_store,
                    displayField: "name",
                    valueField: "name",
                    hiddenName:"target[period]",
                    typeAhead: true,
                    triggerAction: 'all',
                    forceSelection: true,
                    selectOnFocus:true,
                    mode: "remote",
                    valueNotFoundText:"Select an period...",
                    emptyText: "Select an period..."
              })},
             {header:"Goal", dataIndex:"goal",editor:new Ext.form.TextField({})},
             {header:"Achieved", dataIndex:"achieved",editor:new Ext.form.TextField({})}],
    listeners:{
        rowclick:function(grid,number,e){
            target.record_index=number;
            target.id=target.grid.store.data.items[number].data.id;
        }
    }
});
