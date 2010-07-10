var toolBarUsers = new Ext.Toolbar({
    items:[{
        iconCls:"role",
        text:"Roles",
        menu:{
            items:[{
                iconCls:"new",
                text:"New",
                handler:function(){
                    role.method="POST";
                    role.url="roles/create";
                    role.form.getForm().reset();
                    role.win.show();
                }
            },{
                iconCls:"edit",
                text:"Edit",
                handler:function(){
                    role.method="PUT";
                    role.url="/roles/"+role.id;
                    role.form.getForm().load({
                       method:"GET",
                       url:"/roles/"+role.id+"/edit"
                    });
                    role.win.show();
                }
            },{
                iconCls:"del",
                text:"Delete",
                handler:function(){}
            }]
        }
    },{
        iconCls:"user",
        text:"Users",
        menu:{
            items:[{
                iconCls:"new",
                text:"New",
                handler:function(){
                    if (role.id!=0){
                        user.method="POST";
                        user.url="users/create";
                        user.form.getForm().reset();
                        user.form.items.map.user_role_ids.setValue(role.id);
                        user.win.show();
                    }else{
                        Ext.Msg.alert("Error","You must select a role");
                    }
                }
            },{
                iconCls:"edit",
                text:"Edit",
                handler:function(){
                    if (user.id!=0){
                        user.method="PUT";
                        user.url="/users/"+user.id;
                        user.form.getForm().load({
                           method:"GET",
                           url:"/users/"+user.id+"/edit"
                        });
                        user.win.show();
                    }else{
                        Ext.Msg.alert("Error","You must select an user");
                    }
                }
            },{
                iconCls:"del",
                text:"Delete",
                handler:function(){}
            }]
        }
    }]
});

var usersPanel = new Ext.tree.TreePanel({
    id: "tree-panel-users",
    region: 'center',
    width: 500,
    ddGroup: 'dataDDSelf',
    enableDD:true,
    autoScroll: true,
    rootVisible: false,
    useArrows: true,
    loader: new Ext.tree.TreeLoader({
        requestMethod:"GET",
        dataUrl:function() {return "/roles";}
    }),
    listeners:{
        click:function(n){
            if (n.attributes.type=="role")
                role.id=n.attributes.iddb;
            else if (n.attributes.type=="user")
                user.id=n.attributes.iddb;
        }
    },
    root: new Ext.tree.AsyncTreeNode()
});


var toolBarRules=new Ext.Toolbar({
    items:[new Ext.form.Checkbox({id:"checkbox-create",
                                  name:"checkbox-create",boxLabel:"Create"}),"-",
           new Ext.form.Checkbox({id:"checkbox-read",
                                  name:"checkbox-read",boxLabel:"Read"}),"-",
           new Ext.form.Checkbox({id:"checkbox-update",
                                  name:"checkbox-update",boxLabel:"Update"}),"-",
           new Ext.form.Checkbox({id:"checkbox-delete",
                                  name:"checkbox-delete",boxLabel:"Delete"})]
});

var rolesPanel = new Ext.tree.TreePanel({
    id: "tree-panel-roles",
    region: 'center',
    width: 500,
    ddGroup: 'dataDDGroup',
    enableDrop:true,
    autoScroll: true,
    rootVisible: false,
    useArrows: true,
    tbar:[toolBarRules],
    loader: new Ext.tree.TreeLoader({
        requestMethod:"GET",
        dataUrl: "/roles_privileges"
    }),
    root: {
        nodeType: 'async',
        text: 'Privileges',
        draggable: false,
        id: 'src:root'
    },
    listeners:{
        nodedrop:function(o){
            Ext.Ajax.request({
                url:"privileges/create",
                method:"POST",
                params:{node:o.data.node.id,
                        role_id:o.target.attributes.iddb}
            });
        },click:function(o){
            Ext.Ajax.request({
                url:"privileges/show",
                method:"GET",
                params:{id:o.attributes.iddb}
            });
            console.log(o);
        }
    }
});

var privPanel = new Ext.tree.TreePanel({
    useArrows: true,
    region: 'center',
    ddGroup: 'dataDDGroup',
    enableDrag:true,
    autoScroll: true,
    animate: true,
    containerScroll: true,
    border: false,
    loader: new Ext.tree.TreeLoader({
        requestMethod:"GET",
        dataUrl: "/everything"
    }),
    root: {
        nodeType: 'async',
        text: 'Privileges',
        draggable: false,
        id: 'src:root'
    }
});

var viewport = new Ext.Viewport({
    layout: 'border',
    items: [{
        xtype: 'box',
        region: 'north',
        applyTo: 'header',
        height: 27
    }, {
        region: 'west',
        title: 'Users',
        collapsible: true,
        split: true,
        width: 300,
        items:[toolBarUsers,usersPanel]
    },{
        title:'Roles and Privileges',
        region:'center',
        layout: 'border',
        items:[rolesPanel]
    },{
        title: 'Privileges',
        region: 'south',
        split: true,
        layout: 'border',
        height: 300,
        width: 200,
        items:[privPanel]
    }]
});
