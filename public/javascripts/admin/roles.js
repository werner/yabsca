var role = new Object();

role.id=0
role.url="";
role.method="";

role.form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:lang.rolesLabel,
    bodyStyle:'padding:10px 10px 0',
    width: 400,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel:lang.nameLabel,
        id:"role_name",
        name:"role[name]",
        allowBlank: false            
    })]
});

role.win=new Ext.Window({
    layout:'fit',
    width:400,
    height:150,
    closeAction:'hide',
    plain: true,
    items:[role.form],
    buttons: [{
        text:lang.saveLabel,
        iconCls:'save',
        handler: function(){
            role.form.getForm().submit({
                url:role.url,
                method:role.method,
                success: function(){
                    usersPanel.getRootNode().reload();
                    role.win.hide();
                },
                failure: function(response) {
                    Ext.Msg.alert("Error",lang.dataCorrect);
                }
            });
        }
    },{
        text:lang.closeLabel,
        iconCls:'close',
        handler:function(){
            role.win.hide();
        }
    }]
});
