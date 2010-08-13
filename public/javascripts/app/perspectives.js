var perspective = new Object();

perspective.id=0;
perspective.url="";
perspective.method="";
perspective.form= new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:"Perspective",
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel:"Name",
        id:"perspective_name",
        name:"perspective[name]",
        allowBlank: false
    }), new Ext.form.Hidden({
        id:'perspective_strategy_id',
        name:'perspective[strategy_id]'
    })]
});

perspective.win=new Ext.Window({
    layout:'fit',
    width:400,
    height:200,
    closeAction:'hide',
    plain: true,
    items:[perspective.form],
    buttons:[{
        text:"Save",
        iconCls:'save',
        handler:function(){
            perspective.form.getForm().submit({
               url:perspective.url,
               method:perspective.method,
               params:{strategy_id:strategy.id,
                       perspective_id:perspective.id},
               success:function(){
                   treePanelPersp.getRootNode().reload();
                   perspective.win.hide();
               },
               failure: function() {
                   Ext.Msg.alert("Error",
                    "Make sure about all data is correct.");
               }
            });
        }
    },{
        text:"Close",
        iconCls:'close',
        handler:function(){
            perspective.win.hide();
        }
    }]
});

