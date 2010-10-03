var general =new Object();

general.deletion = function(path,treePanel,parameters) {
    Ext.Msg.show({
       title:lang.deleteLabel,
       msg: lang.questionDelete,
       buttons: Ext.Msg.YESNO,
       fn: function(btn){
           if (btn=="yes"){
               Ext.Ajax.request({
                   url:path,
                   method:"DELETE",
                   params:parameters,
                   success:function(){
                        treePanel.getRootNode().reload();
                   }
               });
           }
       },
       animEl: "elId",
       icon: Ext.MessageBox.QUESTION
    });
}

var menuOrgs=new Ext.menu.Menu({
          items:[{
            iconCls:"new",
            text:lang.newLabel,
            handler:function(){
                organization.method="POST";
                organization.url="organizations/create";
                organization.form.getForm().reset();
                organization.form.items.map.organization_organization_id.
                    setValue(organization.id);
                organization.win.show();
            }
          },{
            iconCls:"edit",
            text:lang.editLabel,
            handler:function(){
                if (organization.id>0 &&
                        actualNode.attributes.type=="organization"){
                    organization.method="PUT";
                    organization.url="/organizations/"+organization.id;
                    organization.form.getForm().load(
                        {method:'GET',
                         url:'/organizations/'+organization.id+'/edit'});
                    organization.win.show();
                }else{
                    Ext.Msg.alert("Error",lang.orgSelection);
                }
            }
          },{
            iconCls:"del",
            text:lang.delLabel,
            handler:function(){
                if (organization.id>0 &&
                        actualNode.attributes.type=="organization"){
                      general.deletion("/organizations/"+organization.id,
                            treePanelOrgs,{organization_id:organization.id});
                }else{
                    Ext.Msg.alert("Error",lang.orgSelection);
                }
            }
          }]
});

var menuStrats=new Ext.menu.Menu({
          items:[{
            iconCls:"new",
            text:lang.newLabel,
            handler:function(){
                if (organization.id>0 &&
                        actualNode.attributes.type=="organization"){
                    strategy.method="POST";
                    strategy.url="strategies/create";
                    strategy.form.getForm().reset();
                    strategy.form.items.map.strategy_organization_id.
                        setValue(organization.id);
                    strategy.win.show();
                }else{
                    Ext.Msg.alert("Error",lang.orgSelection);
                }
            }
          },{
            iconCls:"edit",
            text:lang.editLabel,
            handler:function(){
                if (strategy.id>0 &&
                        actualNode.attributes.type=="strategy"){
                    strategy.method="PUT";
                    strategy.url="/strategies/"+strategy.id;
                    strategy.form.getForm().load(
                        {method:'GET',
                         url:'/strategies/'+strategy.id+'/edit'});
                    strategy.win.show();
                }else{
                    Ext.Msg.alert("Error",lang.stratSelection);
                }
            }
          },{
            iconCls:"del",
            text:lang.delLabel,
            handler:function(){
                if (strategy.id>0 &&
                        actualNode.attributes.type=="strategy"){
                      general.deletion("/strategies/"+strategy.id,
                        treePanelOrgs,{strategy_id:strategy.id});
                }else{
                    Ext.Msg.alert("Error",lang.stratSelection);
                }
            }
          },{
            iconCls:"map",
            text:lang.strategyMap,
            handler:function(){
                if (strategy.id>0 &&
                        actualNode.attributes.type=="strategy"){
                    window.location = "/"+locale+"/strategies?id="+strategy.id;
                }else{
                    Ext.Msg.alert("Error",lang.stratSelection);
                }
            }
          }]
});
      
var treePanelOrgs= new Ext.tree.TreePanel({
    id: "tree-panel_org",
    autoScroll: true,
    useArrows: true,
    contextMenu: new Ext.menu.Menu({
        items:[{
            iconCls:"orgs",
            text:lang.orgsLabel,
            menu:menuOrgs
        },{
            iconCls:"strats",
            text:lang.stratsLabel,
            menu:menuStrats
        }]
    }),
    root: {
        nodeType: 'async',
        text: lang.orgsLabel,
        draggable: false,
        iconCls:"orgs",
        id: 'src:root',
        iddb:0
    },
    loader:new Ext.tree.TreeLoader({
        requestMethod:"GET",
        dataUrl:"/org_and_strat"
    }),
    listeners:{
        click: function(n){
            actualNode=n;
            if (n.attributes.type=="organization"){
                organization.parent_id=n.parentNode.attributes.iddb;
                organization.id=n.attributes.iddb;
                strategy.id=0;
            }else if (n.attributes.type=="strategy"){
                organization.parent_id=n.parentNode.attributes.iddb;
                organization.id=n.attributes.iddb;
                strategy.id=n.attributes.iddb;
            }
            treePanelPersp.getRootNode().reload();
            objective.id=0;
            measure.treePanel.getRootNode().reload();
        },
        load:function(n){
            organization.id=0;
            strategy.id=0;
        },
        contextmenu: function(node, e) {
            node.select();
            var c = node.getOwnerTree().contextMenu;
            c.contextNode = node;
            c.showAt(e.getXY());
        }
    }
});

frec_proxy=new Ext.data.HttpProxy({url:"/get_targets",method:"GET"});

frec_reader=new Ext.data.JsonReader({
    idProperty: "id",
    root: "data",
    fields:[{name:"id"},{name:"name"}]
});

frec_store=new Ext.data.Store({
    proxy:frec_proxy,
    reader:frec_reader,
    autoSave: true
});

general.graph_form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:lang.dataChartFormTitle,
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[ new Ext.form.DateField({
        fieldLabel: lang.fromLabel,
        id: "graph_period_from",
        name:"graph_period_from"
    }), new Ext.form.DateField({
        fieldLabel: lang.toLabel,
        id: "graph_period_to",
        name:"graph_period_to"
    }), new Ext.form.RadioGroup({
        fieldLabel: lang.projectionOption,
        itemCls: 'x-check-group-alt',
        id:"proj_options",
        name:"proj_options",
        columns: 1,
        items: [
            {boxLabel: lang.yesLabel, name: 'proj-col', inputValue: 'yes'},
            {boxLabel: 'No', name: 'proj-col', inputValue: 'no', checked: true}
        ]
    })]
});

general.graph_win=new Ext.Window({
    layout:'fit',
    width:400,
    height:250,
    closeAction:'hide',
    plain: true,
    items:[general.graph_form],
    buttons:[{
        text:lang.chartLabel,
        iconCls:'chart',
        handler: function(){
            var graph_data="measure_id="+measure.id+
                    "&date_from="+general.graph_form.items.map.graph_period_from.getValue().format('m/d/Y')+
                    "&date_to="+general.graph_form.items.map.graph_period_to.getValue().format('m/d/Y')+
                    "&proj_options="+general.graph_form.items.map.proj_options.getValue().inputValue;

            general.graph_win.hide();
            window.showModalDialog("/"+locale+"/chart?"+graph_data, "Chart",
                        'dialogWidth:850px;dialogHeight:600px;resizable:no;toolbar:no;menubar:no;scrollbars:no;help: no');

            general.graph_form.getForm().reset();
        }
    },{
        text:lang.closeLabel,
        iconCls:'close',
        handler:function(){
            general.graph_win.hide();
            general.graph_form.getForm().reset();
        }
    }]
});

