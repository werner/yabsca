Ext.onReady(function(){

    var toolBar = new Ext.Toolbar({
        items:[{
            text:"Organizations",
            menu:{
              items:[{
                text:"New",
                handler:function(){
                    organization.method="POST";
                    organization.url="organizations/create";
                    organization.form.getForm().reset();
                    organization.form.items.map.organization_organization_id.
                        setValue(organization.id);
                    organization.win.show();
                }
              },{
                text:"Edit",
                handler:function(){
                    if (organization.id>0){
                        organization.method="PUT";
                        organization.url="/organizations/"+organization.id;
                        organization.form.getForm().load(
                            {method:'GET',
                             url:'/organizations/'+organization.id+'/edit'});
                        organization.win.show();
                    }else{
                        Ext.Msg.alert("Error","You must select an item");
                    }
                }
              },{
                text:"Delete",
                handler:function(){
                    if (organization.id>0){
                        Ext.Msg.show({
                           title:'Delete',
                           msg: 'Are you sure you want to delete it?',
                           buttons: Ext.Msg.YESNO,
                           fn: function(btn){
                               if (btn=='yes'){
                                   Ext.Ajax.request({
                                       url:"/organizations/"+organization.id,
                                       method:"DELETE",
                                       success:function(){
                                           organization.treePanel.getRootNode().reload();
                                       }
                                   });
                               }
                           },
                           animEl: 'elId',
                           icon: Ext.MessageBox.QUESTION
                        });
                    }else{
                        Ext.Msg.alert("Error","You must select an item");
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
                    if (organization.id>0){
                        strategy.method="POST";
                        strategy.url="strategies/create";
                        strategy.form.getForm().reset();
                        strategy.form.items.map.strategy_organization_id.
                            setValue(organization.id);
                        strategy.win.show();
                    }else{
                        Ext.Msg.alert("Error","You must select an item");
                    }
                }
              },{
                text:"Edit"
              },{
                text:"Delete"
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
        title:'A Balanced ScoreCard Application',
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

