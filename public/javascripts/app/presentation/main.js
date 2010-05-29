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
                    organization.method="PUT";
                    organization.url="/organizations/"+organization.id;
                    organization.form.getForm().load(
                        {method:'GET',
                         url:'/organizations/'+organization.id+'/edit'});
                    organization.win.show();
                }
              },{
                text:"Delete"
              }]
            }
        },{
            text:"Strategies",
            menu:{
              items:[{
                text:"New",
                handler:function(btn,e){
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

