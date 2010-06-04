var general =new Object();

general.deletion = function(path,treePanel) {
    Ext.Msg.show({
       title:'Delete',
       msg: 'Are you sure you want to delete it?',
       buttons: Ext.Msg.YESNO,
       fn: function(btn){
           if (btn=='yes'){
               Ext.Ajax.request({
                   url:path,
                   method:"DELETE",
                   success:function(){
                       treePanel.getRootNode().reload();
                   }
               });
           }
       },
       animEl: 'elId',
       icon: Ext.MessageBox.QUESTION
    });
}

var treePanelOrgs= new Ext.tree.TreePanel({
    id: 'tree-panel_org',
    autoScroll: true,
    useArrows: true,
    rootVisible: false,
    loader:new Ext.tree.TreeLoader({
        dataUrl:function(){
            return '/org_and_strat?organization_id='+organization.parent_id;
        }
    }),
    listeners:{
        click: function(n){
            actualNode=n;
            if (n.attributes.type=="organization"){
                organization.parent_id=n.parentNode.attributes.iddb;
                organization.id=n.attributes.iddb;
                strategy.id=0;
            }else{
                organization.parent_id=n.parentNode.attributes.iddb;
                organization.id=n.attributes.iddb;
                strategy.id=n.attributes.iddb;
            }
            treePanelPersp.getRootNode().reload();
        }
    },
    root: new Ext.tree.AsyncTreeNode()
});