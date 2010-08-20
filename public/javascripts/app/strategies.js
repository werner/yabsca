var strategy=new Object();

strategy.id=0;
strategy.url="";
strategy.method="";
strategy.form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:lang.stratsLabel,
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel:lang.nameLabel,
        id:"strategy_name",
        name:"strategy[name]",
        allowBlank: false
    }),new Ext.form.TextArea({
        fieldLabel:lang.descriptionLabel,
        id:"strategy_description",
        name:"strategy[description]"
    }), new Ext.form.Hidden({
        id:'strategy_organization_id',
        name:'strategy[organization_id]'
    })]
});

strategy.win= new Ext.Window({
    layout:'fit',
    width:400,
    height:200,
    closeAction:'hide',
    plain: true,
    items:[strategy.form],
    buttons:[{
        text:lang.saveLabel,
        iconCls:'save',
        handler: function(){
            strategy.form.getForm().submit({
                url:strategy.url,
                method:strategy.method,
                params:{organization_id:organization.id,strategy_id:strategy.id},
                success: function(){
                    treePanelOrgs.getRootNode().reload();
                    strategy.win.hide();
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
            strategy.win.hide();
        }
    }]
});