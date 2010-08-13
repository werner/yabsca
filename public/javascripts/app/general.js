var general =new Object();

general.deletion = function(path,treePanel,parameters) {
    Ext.Msg.show({
       title:"Delete",
       msg: "Are you sure you want to delete it?",
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
            iconCls:"edit",
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
            iconCls:"del",
            text:"Delete",
            handler:function(){
                if (organization.id>0 &&
                        actualNode.attributes.type=="organization"){
                      general.deletion("/organizations/"+organization.id,
                            treePanelOrgs,{organization_id:organization.id});
                }else{
                    Ext.Msg.alert("Error","You must select an organization");
                }
            }
          }]
});

var menuStrats=new Ext.menu.Menu({
          items:[{
            iconCls:"new",
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
            iconCls:"edit",
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
            iconCls:"del",
            text:"Delete",
            handler:function(){
                if (strategy.id>0 &&
                        actualNode.attributes.type=="strategy"){
                      general.deletion("/strategies/"+strategy.id,
                        treePanelOrgs,{strategy_id:strategy.id});
                }else{
                    Ext.Msg.alert("Error","You must select a strategy");
                }
            }
          },{
            iconCls:"map",
            text:"Strategy Map",
            handler:function(){
                if (strategy.id>0 &&
                        actualNode.attributes.type=="strategy"){
                    window.location = "/strategies?id="+strategy.id;
                }else{
                    Ext.Msg.alert("Error","You must select a strategy");
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
            text:"Organizations",
            menu:menuOrgs
        },{
            iconCls:"strats",
            text:"Strategies",
            menu:menuStrats
        }]
    }),
    root: {
        nodeType: 'async',
        text: 'Organizations',
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