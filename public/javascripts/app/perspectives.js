var perspective = new Object();

perspective.id=0;
perspective.url="";
perspective.method="";
perspective.form= new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:lang.perspLabel,
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel:lang.nameLabel,
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
        text:lang.saveLabel,
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
                   Ext.Msg.alert("Error",lang.dataCorrect);
               }
            });
        }
    },{
        text:lang.closeLabel,
        iconCls:'close',
        handler:function(){
            perspective.win.hide();
        }
    }]
});

