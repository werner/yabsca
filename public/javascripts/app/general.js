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