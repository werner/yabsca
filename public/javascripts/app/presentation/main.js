var actualNode;
Ext.onReady(function(){

    var toolBar = new Ext.Toolbar({
        items:[{
            text:"Organizations",
            menu:{
              items:[{
                text:"New",
                handler:function(){
                    if (actualNode.attributes.type=="organization"){
                        organization.method="POST";
                        organization.url="organizations/create";
                        organization.form.getForm().reset();
                        organization.form.items.map.organization_organization_id.
                            setValue(organization.id);
                        organization.win.show();
                    }else{
                        Ext.Msg.alert("Error","You must select an organization");
                    }
                }
              },{
                text:"Edit",
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
                        Ext.Msg.alert("Error","You must select an organization");
                    }
                }
              },{
                text:"Delete",
                handler:function(){
                    if (organization.id>0 &&
                            actualNode.attributes.type=="organization"){
                          general.deletion("/organizations/"+organization.id,organization.treePanel);
                    }else{
                        Ext.Msg.alert("Error","You must select an organization");
                    }
                }
              }]
            }
        },{
            text:"Strategies",
            menu:{
              items:[{
                text:"New",
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
                        Ext.Msg.alert("Error","You must select an organization");
                    }
                }
              },{
                text:"Edit",
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
                        Ext.Msg.alert("Error","You must select a strategy");
                    }                    
                }
              },{
                text:"Delete",
                handler:function(){
                    if (strategy.id>0 &&
                            actualNode.attributes.type=="strategy"){
                          general.deletion("/strategies/"+strategy.id,organization.treePanel);
                    }else{
                        Ext.Msg.alert("Error","You must select a strategy");
                    }
                }
              }]
            }            
        }]
    });
    
    var treePanelPersp = new Ext.tree.TreePanel({
    	id: 'tree-panel_persp',
        title: 'Perspectives and Objectives',
        split: true,
        minSize: 150,
        region: 'north',
        height: 300,
        autoScroll: true,
        rootVisible: false,
        lines: false,
        singleExpand: true,
        useArrows: true,
        width:100,
        loader: new Ext.tree.TreeLoader({
            dataUrl:'/org_and_strat'
        }),
        root: new Ext.tree.AsyncTreeNode()
    });

    var treePanelM = new Ext.tree.TreePanel({
    	id: 'tree-panel_m',
        title: 'Measures',
        split: true,
        minSize: 150,
        region: 'center',
        autoScroll: true,
        rootVisible: false,
        lines: false,
        singleExpand: true,
        width:100,
        useArrows: true,
        loader: new Ext.tree.TreeLoader({
            dataUrl:'/org_and_strat'
        }),
        root: new Ext.tree.AsyncTreeNode()
    });

    var viewport = new Ext.Viewport({
        layout: 'border',
        items: [{
            xtype: 'box',
            region: 'north',
            applyTo: 'header',
            height: 30
        }, {
            region: 'west',
            title: 'Organizations and Strategies',
            split: true,
            width: 400,
            items:[toolBar,organization.treePanel]
        }, {
            region: 'center',
            split: true,
            layout: 'border',
            width: 200,
            items:[treePanelPersp,treePanelM]
        }]
    });
});

