var measure = new Object();

measure.id=0;
measure.url="";
measure.method="";

measure.frecuency_store=new Ext.data.ArrayStore({
   fields: ["id","name"],
   data: [[1,"daily"],[2,"weekly"],[3,"monthly"],[4,"bimonthly"],
          [5,"three-monthly"],[6,"four-monthly"],[7,"yearly"]]
});

measure.challenge_store=new Ext.data.ArrayStore({
   fields: ["id","name"],
   data: [[1,"increasing"],[2,"decreasing"]]
});

measure.form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:"Measure",
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel: "Code",
        id: "measure_code",
        name:"measure[code]",
        allowBlank: false
    }),new Ext.form.TextField({
        fieldLabel: "Name",
        id: "measure_name",
        name:"measure[name]",
        allowBlank: false
    }), new Ext.form.TextArea({
        fieldLabel: "Description",
        id: "measure_description",
        name: "measure[description]"
    }), new Ext.form.ComboBox({
        fieldLabel: "Challenge",
        displayField: "name",
        valueField: "id",
        hiddenName:"measure[challenge]",
        name: "measure[challenge]",
        typeAhead: true,
        store: measure.challenge_store,
        mode: "local",
        forceSelection: true,
        triggerAction: 'all',
        selectOnFocus:true,
        valueNotFoundText:"Select a challenge...",
        emptyText: "Select a challenge..."
    }), new Ext.form.NumberField({
        fieldLabel: "Excellent",
        id: "measure_excellent",
        name: "measure[excellent]"
    }), new Ext.form.NumberField({
        fieldLabel: "Alert",
        id: "measure_alert",
        name: "measure[alert]"
    }), new Ext.form.ComboBox({
        fieldLabel: "Frecuency",
        displayField: "name",
        valueField: "id",
        hiddenName:"measure[frecuency]",
        name: "measure[frecuency]",
        typeAhead: true,
        store: measure.frecuency_store,
        mode: "local",
        forceSelection: true,
        triggerAction: 'all',
        selectOnFocus:true,
        valueNotFoundText:"Select a frecuency...",
        emptyText: "Select a frecuency..."
    }), new Ext.form.DateField({
        fieldLabel: "From",
        id: "measure_period_from",
        name:"measure[period_from]"
    }), new Ext.form.DateField({
        fieldLabel: "To",
        id: "measure_period_to",
        name:"measure[period_to]"
    }), new Ext.form.ComboBox({
        id:"measure_unit_id",
        fieldLabel: "Unit",
        name: "measure[unit_id]",
        store: unit.store,
        displayField: "name",
        valueField: "id",
        hiddenName:"measure[unit_id]",
        typeAhead: true,
        triggerAction: 'all',
        forceSelection: true,
        selectOnFocus:true,
        mode: "remote",
        valueNotFoundText:"Select an unit...",
        emptyText: "Select an unit..."
    }),new Ext.form.ComboBox({
        id:"measure_responsible_id",
        fieldLabel: "Responsible",
        name: "measure[responsible_id]",
        store: responsible.store,
        displayField: "name",
        valueField: "id",
        hiddenName:"measure[responsible_id]",
        typeAhead: true,
        triggerAction: 'all',
        forceSelection: true,
        selectOnFocus:true,
        mode: "remote",
        valueNotFoundText:"Select an responsible...",
        emptyText: "Select an responsible..."
    }),new Ext.form.Hidden({
        id:"measure_objective_ids",
        name:"measure[objective_ids][]"
    })]
});

measure.win=new Ext.Window({
    layout:'fit',
    width:400,
    height:500,
    closeAction:'hide',
    plain: true,
    items:[measure.form],
    buttons:[{
        text:'Save',
        iconCls:'save',
        handler: function(){
            measure.form.getForm().submit({
                url:measure.url,
                method:measure.method,
                success: function(){
                    measure.treePanel.getRootNode().reload();
                    measure.win.hide();
                },
                failure: function() {
                    Ext.Msg.alert("Error",
                    "Make sure about all data is correct.");
                }
            });
        }
    },{
        text:'Close',
        iconCls:'close',
        handler:function(){
            measure.win.hide();
        }
    }]
});

measure.menuMeasures=new Ext.menu.Menu({
       items:[{
           text: "New",
           iconCls: "new",
           handler:function(){
                if (objective.id>0){
                    measure.method="POST";
                    measure.url="measures/create";
                    measure.form.getForm().reset();
                    measure.form.items.map.measure_objective_ids.
                        setValue(objective.id);
                    measure.win.show();
                }else{
                    Ext.Msg.alert("Error","You must select an objective");
                }
           }
       },{
           text:"Edit",
           iconCls: "edit",
           handler:function(){
               if (measure.id>0){
                   measure.method="PUT";
                   measure.url="/measures/"+measure.id;
                   measure.form.getForm().load(
                        {method:'GET',
                         url:'/measures/'+measure.id+'/edit'});
                   measure.win.show();
                }else{
                    Ext.Msg.alert("Error","You must select a measure");
                }
           }
       },{
           text: "Delete",
           iconCls: "del",
           handler:function(){
                if (measure.id>0){
                    general.deletion("/measures/"+measure.id,measure.treePanel);
                }else{
                    Ext.Msg.alert("Error","You must select a measure");
                }
           }
       },"-",{
           text:"Formula",
           iconCls:"formula_icon",
           handler:function(){
               if (measure.id>0){
                    Ext.Ajax.request({
                        url:"/get_formula",
                        method:"GET",
                        params:{id:measure.id},
                        success:function(response){
                            measure.formulaText.setValue(response.responseText);
                        }
                    });
                    measure.win_formula.show();
               }else
                    Ext.Msg.alert("Error","You must select a measure");

           }
       }]
});

measure.toolBar=new Ext.Toolbar({
    items:[{
       text:"Measures",
       iconCls:"measure",
       menu:measure.menuMeasures
    },{
       text:"Units",
       iconCls:"unit",
       handler:function(){
            unit.win.show();
       }
    },{
       text:"Responsibles",
       iconCls:"responsible",
       handler:function(){
            responsible.win.show();
       }
    },"-",
    {
       text:"Chart",
       iconCls:"chart",
       handler:function(){
            fchart.type="FCF_Column3D.swf";
            fchart.win.show();
       }        
    }]
});

measure.treePanel = new Ext.tree.TreePanel({
    id: "tree-panel_m",
    title: "Measures",
    region: "west",
    split: true,
    collapsible: true,
    autoScroll: true,
    rootVisible: false,
    lines: false,
    singleExpand: true,
    width:500,
    useArrows: true,
    contextMenu:measure.menuMeasures,
    tbar:[measure.toolBar],
    loader: new Ext.tree.TreeLoader({
        requestMethod:"GET",
        dataUrl:function() {return "/measures?objective_id="+objective.id}
    }),
    listeners:{
        click:function(n){
            measure.id=n.id;
            target.store.setBaseParam("measure_id",measure.id);
            target.store.load();
            target.frec_store.setBaseParam("measure_id",measure.id);
            target.frec_store.load();
            target.id=0;
        },
        load:function(n){
            measure.id=0;
            target.id=0;
            target.store.setBaseParam("measure_id",0);
            target.store.load();
        },
        contextmenu: function(node, e) {
            node.select();
            var c = node.getOwnerTree().contextMenu;
            c.contextNode = node;
            c.showAt(e.getXY());
        }
    },
    root: new Ext.tree.AsyncTreeNode()
});

measure.allTreePanel = new Ext.tree.TreePanel({
    id: "tree-panel_m",
    title: "Measures",
    ddGroup: 'dataDDGroup',
    region: "center",
    split: true,
    enableDrag:true,
    autoScroll: true,
    rootVisible: false,
    lines: false,
    singleExpand: true,
    width:100,
    useArrows: true,
    loader: new Ext.tree.TreeLoader({
        requestMethod:"GET",
        dataUrl:function() {return "/all_measures?strategy_id="+strategy.id}
    }),
    root: new Ext.tree.AsyncTreeNode()
});

measure.formulaText=new Ext.form.TextArea({
    id:'formula_text',
    name:'formulaText',
    width:400,
    height: 300,
    listeners: {
        render: function(g){
            var dropTarget = new Ext.dd.DropTarget(g.container.dom,{
              ddGroup: 'dataDDGroup',
              copy: false,
              overClass: 'over',
              notifyDrop: function(dragSource, event, data){
                if (dragSource.id=="ext-comp-1072")
                    measure.formulaText.setValue(measure.formulaText.getValue()+
                        data.patientData.value);
                else
                    measure.formulaText.setValue(measure.formulaText.getValue()+
                        '<c>'+data.node.attributes.code+'</c>');
              }
            });
        }
    }
});

measure.topData=[{id:1, name:"sum",value:"+"},{id:2, name:"subtract",value:"-"},
    {id:3, name:"multiply",value:"*"},
    {id:4, name:"divide",value:"/"},{id:5, name:"open_bracket",value:"("},
    {id:6,name:"close_bracket",value:")"}]

measure.record = Ext.data.Record.create([{name: 'id'}, {name: 'name'}, {name: 'value'}]);

measure.topStore = new Ext.data.Store({
    data: measure.topData,
    reader: new Ext.data.JsonReader({
        id: 'id'
    }, measure.record)
});

measure.topView=new Ext.DataView({
    store: measure.topStore,
    cls: 'top-view',
    tpl: new Ext.XTemplate(
    '<table><tr><tpl for=".">',
        '<td><div class="top-wrap"><div id="squares" class="{name}"></div></div></td>',
    '</tpl></tr></table>'),
    selectedClass: 'formula-selected',
    singleSelect: true,
    overClass:'top-over',
    itemSelector:'div.top-wrap',
    listeners: {
        render: initializeDragZone
    }
});

measure.win_formula=new Ext.Window({
    layout:"border",
    width:700,
    height:400,
    split: true,
    closeAction:"hide",
    plain: true,
    items:[{
        region:'north',
        height:50,
        items:measure.topView
    },{
        title: 'Formula',
        region: 'west',
        width:400,
        items: measure.formulaText
    },measure.allTreePanel],
    buttons: [{
        text:'Check Formula',
        iconCls:'check',
        handler:function(){
            Ext.Ajax.request({
                url:"/check_formula",
                method:"GET",
                params:{formula:measure.formulaText.getValue()},
                success:function(response){
                    if (response.responseText=="true")
                        Ext.Msg.show({title:"formula checker",
                                       msg: "syntax error",buttons: Ext.Msg.OK});
                    else
                        Ext.Msg.show({title:"formula checker",
                                       msg: "syntax correct",buttons: Ext.Msg.OK});
                }
            });
        }
    },{
        text:'Save Formula',
        iconCls:'save',
        handler:function(){
            Ext.Ajax.request({
                url:"/check_formula",
                method:"GET",
                params:{formula:measure.formulaText.getValue()},
                success:function(response){
                    if (response.responseText=="true")
                        Ext.Msg.show({title:"formula checker",
                                       msg: "syntax error",buttons: Ext.Msg.OK});
                    else
                        Ext.Ajax.request({
                            url:"/measures/"+measure.id,
                            method:"PUT",
                            params:{id:measure.id,
                                    "measure[formula]":measure.formulaText.getValue()},
                            success:function(){
                                measure.win_formula.hide();
                                Ext.Ajax.request({
                                    url:"/get_all_targets",
                                    method:"GET",
                                    params:{id:measure.id},
                                    success:function(response){
                                        var result=JSON.parse(response.responseText);
                                        for (var i=0;i<result.length;i++){
                                            Ext.Ajax.request({
                                                url:"/save_target",
                                                method:"POST",
                                                params:{measure_id:measure.id,
                                                        period:result[i].target.period,
                                                        formula:measure.formulaText.getValue()}
                                            });
                                        }
                                    }
                                });
                            }
                        });
                }
            });
        }
    },{
        text:'Close',
        iconCls:'close',
        handler:function(){
            measure.win_formula.hide();
        }
    }],
    listeners:{
        show:function(){
            measure.allTreePanel.getRootNode().reload();
        }
    }
});

function initializeDragZone(v) {
    v.dragZone = new Ext.dd.DragZone(v.getEl(), {
        ddGroup: 'dataDDGroup',
        getDragData: function(e) {
            var sourceEl = e.getTarget(v.itemSelector, 10);
            if (sourceEl) {
                d = sourceEl.cloneNode(true);
                d.id = Ext.id();
                return v.dragData = {
                    sourceEl: sourceEl,
                    repairXY: Ext.fly(sourceEl).getXY(),
                    ddel: d,
                    patientData: v.getRecord(sourceEl).data
                }
            }
        },
        getRepairXY: function() {
            return this.dragData.repairXY;
        }
    });
}
