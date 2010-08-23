var login = new Ext.FormPanel({
    labelWidth:80,
    url:'/user_sessions/create',
    frame:true,
    title:lang.loginTitle,
    defaultType:'textfield',
    monitorValid:true,
    items:[{
            fieldLabel:lang.fieldUserName,
            name:'user_session[login]',
            allowBlank:false
        },{
            fieldLabel:lang.fieldPassword,
            name:'user_session[password]',
            inputType:'password',
            allowBlank:false,
            listeners: {
                specialkey: function(field, e){
                    if (e.getKey() == e.ENTER) {
                        send_login('/'+locale+'/presentation');
                    }
                }
            }
        }],
    buttons:[{
            text:lang.loginButton,
            iconCls:'login',
            formBind: true,
            handler:function(){
                send_login('/'+locale+'/presentation');
            }
        },{
            text:lang.adminLabel,
            iconCls:'admin',
            formBind: true,
            handler: function(){
                send_login('/'+locale+'/admin');
            }
        }]
});

var send_login=function(path){
    login.getForm().submit({
        method:'POST',
        waitTitle:lang.waitTitle,
        waitMsg:lang.waitMsg,
        success:function(){
            var redirect = path;
            window.location = redirect;
        },
        failure:function(form, action){
            if(action.failureType == 'server'){
                obj = Ext.util.JSON.decode(action.response.responseText);
                Ext.Msg.alert(lang.loginFailed, obj.errors.msg);
            }else{
                Ext.Msg.alert(lang.loginWarning, lang.loginMsg +
                    action.response.responseText);
            }
            login.getForm().reset();
        }
    });

}

var win = new Ext.Window({
    layout:'fit',
    width:300,
    height:150,
    closable: false,
    resizable: false,
    plain: true,
    border: false,
    items: [login]
});

win.show();