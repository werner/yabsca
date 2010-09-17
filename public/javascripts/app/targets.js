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
        text:lang.newLabel,
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
                Ext.Msg.alert("Error",lang.measureSelection);
            }
        }
    },{
        text:lang.saveLabel,
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
                                "target[achieved]":records[i].data.achieved,
                                measure_id:measure.id}
                    });
                }else{
                    Ext.Ajax.request({
                        url:"/targets/"+records[i].data.id,
                        method:"PUT",
                        params:{"target[period]":records[i].data.period,
                                "target[goal]":records[i].data.goal,
                                "target[achieved]":records[i].data.achieved,
                                measure_id:measure.id}
                    });
                }
            }
            target.grid.store.commitChanges();
        }
    },{
        text:lang.delLabel,
        iconCls:"del",
        handler:function(){
            if (target.id>0){
                Ext.Msg.show({
                   title:lang.delLabel,
                   msg: lang.questionDelete,
                   buttons: Ext.Msg.YESNO,
                   fn: function(btn){
                       if (btn=="yes"){
                           Ext.Ajax.request({
                               url:"/targets/"+target.id,
                               method:"DELETE",
                               params:{measure_id:measure.id},
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
                Ext.Msg.alert("Error",lang.targetSelection);
            }
        }
    },{
        text:lang.calculate,
        iconCls:"calc",
        handler:function(){
            Ext.Ajax.request({
                url:"/get_all_targets",
                method:"GET",
                params:{id:measure.id},
                success:function(response){
                    var result=JSON.parse(response.responseText);
                    Ext.Ajax.request({
                        url:"/get_formula",
                        method:"GET",
                        params:{id:measure.id},
                        success:function(response){
                            if (response.responseText=="")
                                Ext.Msg.alert("Error",lang.measureNoCalc);
                            else
                                for (var i=0;i<result.length;i++){
                                    Ext.Ajax.request({
                                        url:"/save_target",
                                        method:"POST",
                                        params:{measure_id:measure.id,
                                                period:result[i].target.period,
                                                formula:response.responseText}
                                    });
                                }
                            target.store.load();
                        }
                    });
                }
            });
        }
    }]
});

target.frec_proxy=new Ext.data.HttpProxy({url:"/get_targets",method:"GET"});

target.frec_reader=new Ext.data.JsonReader({
    idProperty: "id",
    root: "data",
    fields:[{name:"id"},{name:"name"}]
});

target.frec_store=new Ext.data.Store({
    proxy:target.frec_proxy,
    reader:target.frec_reader,
    autoSave: true
});

target.grid=new Ext.grid.EditorGridPanel({
    region: "center",
    title:lang.targetsLabel,
    store:target.store,
    clicksToEdit: 2,
    tbar:[target.toolBar],
    columns:[{header:"id",dataIndex:"id", hidden:true},
             {header:lang.periodLabel, dataIndex:"period",width:150,
                 editor: new Ext.form.ComboBox({
                    id: "target_period_id",
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
                    valueNotFoundText:lang.emptyPeriod,
                    emptyText: lang.emptyPeriod
              })},
             {header:lang.targetGoal, dataIndex:"goal",editor:new Ext.form.TextField({})},
             {header:lang.achievedLabel, dataIndex:"achieved",editor:new Ext.form.TextField({})}],
    listeners:{
        rowclick:function(grid,number,e){
            target.record_index=number;
            target.id=target.grid.store.data.items[number].data.id;
        }
    }
});
