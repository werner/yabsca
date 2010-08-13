var actualNode;
var actualNode2;
var treePanelPersp;

Ext.onReady(function(){

    var menuPersp= new Ext.menu.Menu({
            items:[{
                iconCls:"new",
                text:"New",
                handler:function(){
                    if (actualNode!=undefined &&
                            actualNode.attributes.type=="strategy"){
                        perspective.method="POST";
                        perspective.url="perspectives/create";
                        perspective.form.getForm().reset();
                        perspective.form.items.map.perspective_strategy_id.
                            setValue(strategy.id);
                        perspective.win.show();
                    }else{
                        Ext.Msg.alert("Error","You must select a strategy");
                    }
                }
            },{
                iconCls:"edit",
                text:"Edit",
                handler:function(){
                    if (perspective.id>0 &&
                            actualNode2.attributes.type=="perspective"){
                        perspective.method="PUT";
                        perspective.url="/perspectives/"+perspective.id;
                        perspective.form.getForm().load({
                           method:"GET",
                           url:"/perspectives/"+perspective.id+"/edit"
                        });
                        perspective.win.show();
                    }else{
                        Ext.Msg.alert("Error","You must select a perspective");
                    }
                }
            },{
                iconCls:"del",
                text:"Delete",
                handler:function(){
                    if (perspective.id>0 &&
                            actualNode2.attributes.type=="perspective"){
                          general.deletion("/perspectives/"+perspective.id,
                            treePanelPersp,{perspective_id:perspective.id});
                    }else{
                        Ext.Msg.alert("Error","You must select a perspective");
                    }
                }
            }]
    });

    var menuObjs= new Ext.menu.Menu({
            items:[{
                iconCls:"new",
                text:"New",
                handler:function(){
                    if (actualNode2.attributes.type=="perspective" ||
                            actualNode2.attributes.type=="objective"){
                        objective.method="POST";
                        objective.url="objectives/create";
                        objective.form.getForm().reset();
                        objective.form.items.map.objective_perspective_id.
                            setValue(perspective.id);
                        objective.form.items.map.objective_objective_id.
                            setValue(objective.id);
                        objective.win.show();
                    }else{
                        Ext.Msg.alert("Error","You must select a perspective or objective");
                    }
                }
            },{
                iconCls:"edit",
                text:"Edit",
                handler:function(){
                    if (objective.id>0 &&
                            actualNode2.attributes.type=="objective"){
                        objective.method="PUT";
                        objective.url="/objectives/"+objective.id;
                        objective.form.getForm().load({
                           method:"GET",
                           url:"/objectives/"+objective.id+"/edit"
                        });
                        objective.win.show();
                    }else{
                        Ext.Msg.alert("Error","You must select an objective");
                    }
                }
            },{
                iconCls:"del",
                text:"Delete",
                handler:function(){
                    if (objective.id>0 &&
                            actualNode2.attributes.type=="objective"){
                          general.deletion("/objectives/"+objective.id,
                            treePanelPersp,{objective_id:objective.id});
                    }else{
                        Ext.Msg.alert("Error","You must select an objective");
                    }
                }
            }]
    });

    var toolBarPers = new Ext.Toolbar({
        items:[{
            iconCls:"persp",
            text:"Perspectives",
            menu:menuPersp
        },{
            iconCls:"objs",
            text:"Objectives",
            menu:menuObjs
        },{
           text:"Gantt",
           iconCls:"gantt",
           handler:function(){
                fchart.type="FCF_Gantt.swf";
                fchart.win.show();
           }
        }]
    });
      
    var toolBarOrgs = new Ext.Toolbar({
        items:[{
            iconCls:"orgs",
            text:"Organizations",
            menu:menuOrgs
        },{
            iconCls:"strats",
            text:"Strategies",
            menu:menuStrats
        }]
    });
    
    treePanelPersp = new Ext.tree.TreePanel({
    	id: "tree-panel_persp",
        title: "Perspectives and Objectives",
        region: "west",
        split: true,
        collapsible: true,
        width: 500,
        autoScroll: true,
        useArrows: true,
        contextMenu: new Ext.menu.Menu({
            items:[{
                iconCls:"persp",
                text:"Perspectives",
                menu:menuPersp
            },{
                iconCls:"objs",
                text:"Objectives",
                menu:menuObjs
            }]
        }),
        root: {
            nodeType: 'async',
            text: 'Perspectives',
            draggable: false,
            iconCls:"persp",
            id: 'src:root'
        },
        tbar:[toolBarPers],
        loader: new Ext.tree.TreeLoader({
            requestMethod:"GET",
            dataUrl:function() {return "/persp_and_objs?strategy_id="+strategy.id;}
        }),
        listeners:{
            click:function(n){
                actualNode2=n;
                if (n.attributes.type=="perspective"){
                    perspective.id=n.attributes.iddb;
                    objective.id=0;
                }else{
                    perspective.id=0;
                    objective.id=n.attributes.iddb;
                }
                measure.treePanel.getRootNode().reload();
                initiative.treePanel.getRootNode().reload();
            },
            load:function(n){
                perspective.id=0;
                objective.id=0;
                initiative.id=0;
            },
            contextmenu: function(node, e) {
                node.select();
                var c = node.getOwnerTree().contextMenu;
                c.contextNode = node;
                c.showAt(e.getXY());
            }
        }
    });

    var measurePanel= new Ext.Panel({
        layout:"border",
        region: "center",
        items:[measure.treePanel,target.grid]
    });

    var perspPanel = new Ext.Panel({
        layout:"border",
        region: "north",
        height:300,
        items:[treePanelPersp,initiative.treePanel]
    });

    var viewport = new Ext.Viewport({
        layout: 'border',
        items: [{
            xtype: 'box',
            region: 'north',
            applyTo: 'header',
            height: 27
        }, {
            region: 'west',
            title: 'Organizations and Strategies',
            collapsible: true,
            split: true,
            width: 300,
            items:[toolBarOrgs,treePanelOrgs]
        }, {
            region: 'center',
            split: true,
            layout: 'border',
            width: 200,
            items:[perspPanel,measurePanel]
        }]
    });
});