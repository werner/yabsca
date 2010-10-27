var measure = new Object();

var cut=false;
var copy=false;
var link=false;

actualMeasure=0;

measure.id=0;
measure.url="";
measure.method="";

measure.frecuency_store=new Ext.data.ArrayStore({
   fields: ["id","name"],
   data: [[1,lang.daily],[6,lang.weekly],[5,lang.monthly],[2,lang.bimonthly],
          [3,lang.three_monthly],[4,lang.four_monthly],[7,lang.yearly]]
});

measure.challenge_store=new Ext.data.ArrayStore({
   fields: ["id","name"],
   data: [[1,lang.increasing],[2,lang.decreasing]]
});

measure.form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:lang.measuresLabel,
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel: lang.codeLabel,
        id: "measure_code",
        name:"measure[code]",
        allowBlank: false
    }),new Ext.form.TextField({
        fieldLabel: lang.nameLabel,
        id: "measure_name",
        name:"measure[name]",
        allowBlank: false
    }), new Ext.form.TextArea({
        fieldLabel: lang.descriptionLabel,
        id: "measure_description",
        name: "measure[description]"
    }), new Ext.form.ComboBox({
        fieldLabel: lang.challengeLabel,
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
        valueNotFoundText:lang.emptyChallenge,
        emptyText: lang.emptyChallenge
    }), new Ext.form.NumberField({
        fieldLabel: lang.excellentLabel,
        id: "measure_excellent",
        name: "measure[excellent]"
    }), new Ext.form.NumberField({
        fieldLabel: lang.alertLabel,
        id: "measure_alert",
        name: "measure[alert]"
    }), new Ext.form.ComboBox({
        fieldLabel: lang.frecLabel,
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
        valueNotFoundText:lang.emptyFrecuency,
        emptyText: lang.emptyFrecuency
    }), new Ext.form.DateField({
        fieldLabel: lang.fromLabel,
        id: "measure_period_from",
        name:"measure[period_from]"
    }), new Ext.form.DateField({
        fieldLabel: lang.toLabel,
        id: "measure_period_to",
        name:"measure[period_to]"
    }), new Ext.form.ComboBox({
        id:"measure_unit_id",
        fieldLabel: lang.unitLabel,
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
        valueNotFoundText:lang.emptyUnit,
        emptyText: "Select an unit..."
    }),new Ext.form.ComboBox({
        id:"measure_responsible_id",
        fieldLabel: lang.respsLabel,
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
        valueNotFoundText:lang.emptyResp,
        emptyText: lang.emptyResp
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
        text:lang.saveLabel,
        iconCls:'save',
        handler: function(){
            measure.form.getForm().submit({
                url:measure.url,
                method:measure.method,
                params:{objective_id:objective.id,measure_id:measure.id},
                success: function(){
                    measure.treePanel.getRootNode().reload();
                    measure.win.hide();
                },
                failure: function() {
                    Ext.Msg.alert("Error",lang.dataCorrect);
                }
            });
        }
    },{
        text:lang.closeLabel,
        iconCls:'close',
        handler:function(){
            measure.win.hide();
        }
    }]
});

measure.menuMeasures=new Ext.menu.Menu({
       items:[{
           text: lang.newLabel,
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
                    Ext.Msg.alert("Error",lang.objSelection);
                }
           }
       },{
           text:lang.editLabel,
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
                    Ext.Msg.alert("Error",lang.measureSelection);
                }
           }
       },{
           text: lang.deleteLabel,
           iconCls: "del",
           handler:function(){
                if (measure.id>0){
                    general.deletion("/measures/"+measure.id,
                        measure.treePanel,{measure_id:measure.id});
                }else{
                    Ext.Msg.alert("Error",lang.measureSelection);
                }
           }
       },"-",{
           text:lang.formulaLabel,
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
                    Ext.Msg.alert("Error",lang.measureSelection);

           }
       },"-",{
           text:lang.chartLabel,
           iconCls:"chart",
           handler:function(){
                general.graph_win.show();
           }        
        },/*{
           text:lang.treeProcess,
           iconCls:"chart",
           handler:function(){
                window.showModalDialog("/"+locale+"/tree?measure_id="+measure.id, lang.treeProcess,
                            'dialogWidth:850px;dialogHeight:600px;resizable:no;toolbar:no;menubar:no;scrollbars:no;help: no');
           }        
    }*/]
});

measure.menuMovings=new Ext.menu.Menu({
       items:[{
           text: lang.cutLabel,
           iconCls: "cut",
           handler:function(){
               cut=true;
           }
       },{
           text:lang.copyLabel,
           iconCls: "copy",
           handler:function(){
               copy=true;
           }
       },{
           text:lang.linkLabel,
           iconCls: "link",
           handler:function(){
               link=true;
           }
       },{
           text: lang.pasteLabel,
           iconCls: "paste",
           handler:function(){
               Ext.Ajax.request({
                    url:"/pasting",
                    method:"POST",
                    params:{objective_id:objective.id,measure_id:actualMeasure,
                            cut:cut,copy:copy,link:link},
                    success:function(response){
                        measure.treePanel.getRootNode().reload();
                    }
               });
               cut=false;
               copy=false;
               link=false;
           }
       }]
});

measure.toolBar=new Ext.Toolbar({
    items:[{
       text:lang.measuresLabel,
       iconCls:"measure",
       menu:measure.menuMeasures
    },{
        text:lang.movingLabel,
        iconCls:"go",
        menu:measure.menuMovings
    },{
       text:lang.unitLabel,
       iconCls:"unit",
       handler:function(){
            unit.win.show();
       }
    },{
       text:lang.respsLabel,
       iconCls:"responsible",
       handler:function(){
            responsible.win.show();
       }
    }]
});

measure.treePanel = new Ext.tree.TreePanel({
    id: "tree-panel_m",
    title: lang.measuresLabel,
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
            actualMeasure=n.id;
            measure.id=n.id;
            target.store.setBaseParam("measure_id",measure.id);
            target.store.load();
            target.frec_store.setBaseParam("measure_id",measure.id);
            target.frec_store.load();
            frec_store.setBaseParam("measure_id",measure.id);
            frec_store.load();
            target.id=0;
        },
        load:function(n){
            measure.id=0;
            target.id=0;
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
    id: "tree-panel_m_all",
    title: lang.measuresLabel,
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
                if (dragSource.dragData.node==undefined)
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
    {id:3, name:"multiply",value:"*"},{id:4, name:"divide",value:"/"},{id:5, name:"open_bracket",value:"("},
    {id:6, name:"close_bracket",value:")"},{id:7, name:"sum_all",value:"sum"},{id:8, name:"avg",value:"average"}]

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
        '<td><div class="top-wrap"><button type="button" id="squares" class="{name}" value="{value}"></button></div></div></td>',
    '</tpl></tr></table>'),
    selectedClass: 'formula-selected',
    singleSelect: true,
    overClass:'top-over',
    itemSelector:'div.top-wrap',
    listeners:{
        click:function(dataView,index,node,e){
            measure.formulaText.setValue(measure.formulaText.getValue()+node.children[0].value);
        }
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
        title: lang.formulaLabel,
        region: 'west',
        width:400,
        items: measure.formulaText
    },measure.allTreePanel],
    buttons: [{
        text:lang.changeFormula,
        iconCls:'check',
        handler:function(){
            Ext.Ajax.request({
                url:"/check_formula",
                method:"GET",
                params:{formula:measure.formulaText.getValue()},
                success:function(response){
                    if (response.responseText=="true")
                        Ext.Msg.show({title:lang.formulaChecker,
                                       msg: lang.syntaxError ,buttons: Ext.Msg.OK});
                    else
                        Ext.Msg.show({title:lang.formulaChecker,
                                       msg: lang.syntaxCorrect,buttons: Ext.Msg.OK});
                }
            });
        }
    },{
        text:lang.saveFormula,
        iconCls:'save',
        handler:function(){
            Ext.Ajax.request({
                url:"/check_formula",
                method:"GET",
                params:{formula:measure.formulaText.getValue()},
                success:function(response){
                    if (response.responseText=="true")
                        Ext.Msg.show({title:lang.formulaChecker,
                                       msg: lang.syntaxError,buttons: Ext.Msg.OK});
                    else
                        Ext.Ajax.request({
                            url:"/measures/"+measure.id,
                            method:"PUT",
                            params:{id:measure.id,
                                    "measure[formula]":measure.formulaText.getValue(),
                                    measure_id:measure.id},
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
        text:lang.closeLabel,
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
