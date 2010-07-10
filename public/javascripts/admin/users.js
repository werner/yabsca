var user = new Object();

user.id=0
user.url="";
user.method="";

user.form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:"User",
    bodyStyle:'padding:10px 10px 0',
    width: 400,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel:"Login",
        id:"user_login",
        name:"user[login]",
        allowBlank: false
    }), new Ext.form.TextField({
        fieldLabel:"Email",
        id:'user_email',
        name:'user[email]'
    }),new Ext.form.TextField({
        fieldLabel:"Password",
        id:'user_password',
        inputType:'password',
        name:'user[password]'
    }),new Ext.form.TextField({
        fieldLabel:"Password Confirmation",
        id:'user_password_confirmation',
        inputType:'password',
        name:'user[password_confirmation]'
    }),new Ext.form.Hidden({
        id:"user_role_ids",
        name:"user[role_ids][]"
    })]
});

user.win=new Ext.Window({
    layout:'fit',
    width:400,
    height:250,
    closeAction:'hide',
    plain: true,
    items:[user.form],
    buttons: [{
        text:'Save',
        iconCls:'save',
        handler: function(){
            user.form.getForm().submit({
                url:user.url,
                method:user.method,
                success: function(){
                    usersPanel.getRootNode().reload();
                    user.win.hide();
                },
                failure: function(response) {
                    Ext.Msg.alert("Error",
                    "Make sure about all data is correct.");
                }
            });
        }
    },{
        text:'Close',
        iconCls:'close',
        handler:function(){
            user.win.hide();
        }
    }]
});