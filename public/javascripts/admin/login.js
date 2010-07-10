var login = new Ext.FormPanel({
    labelWidth:80,
    url:'/user_sessions/create',
    frame:true,
    title:'Please Login',
    defaultType:'textfield',
    monitorValid:true,
    items:[{
            fieldLabel:'Username',
            name:'user_session[login]',
            allowBlank:false
        },{
            fieldLabel:'Password',
            name:'user_session[password]',
            inputType:'password',
            allowBlank:false
        }],
    buttons:[{
            text:'Login',
            iconCls:'login',
            formBind: true,
            handler:function(){
                login.getForm().submit({
                    method:'POST',
                    waitTitle:'Connecting',
                    waitMsg:'Sending data...',
                    success:function(){
                        var redirect = '/presentation';
                        window.location = redirect;
                    },
                    failure:function(form, action){
                        if(action.failureType == 'server'){
                            obj = Ext.util.JSON.decode(action.response.responseText);
                            Ext.Msg.alert('Login Failed!', obj.errors.msg);
                        }else{
                            Ext.Msg.alert('Warning!', 'Authentication server is unreachable : ' +
                                action.response.responseText);
                        }
                        login.getForm().reset();
                    }
                });
            }
        },{
            text:'Admin',
            iconCls:'admin',
            formBind: true,
            handler: function(){
                login.getForm().submit({
                    method:'POST',
                    waitTitle:'Connecting',
                    waitMsg:'Sending data...',
                    success:function(){
                        var redirect = '/admin';
                        window.location = redirect;
                    },
                    failure:function(form, action){
                        if(action.failureType == 'server'){
                            obj = Ext.util.JSON.decode(action.response.responseText);
                            Ext.Msg.alert('Login Failed!', obj.errors.msg);
                        }else{
                            Ext.Msg.alert('Warning!', 'Authentication server is unreachable : ' +
                                action.response.responseText);
                        }
                        login.getForm().reset();
                    }
                });
            }
        }]
});

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