Ext.onReady(function() {
    Ext.QuickTips.init();
});

var privilege = new Object();
var actualNodeU;

privilege.id=0;
privilege.module=0;
privilege.role_id=0;
privilege.module_id=0;
privilege.privilege=0;

const Create=1;
const Read=2;
const Update=3;
const Delete=4;

var role_menu=new Ext.menu.Menu({
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
        handler:function(){
            if (role.id>0 &&
                actualNodeU.attributes.type=="role"){
                  general.deletion("/roles/"+role.id,usersPanel);
            }else{
                Ext.Msg.alert("Error","You must select a role");
            }
        }
    }]
});

var user_menu = new Ext.menu.Menu({
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
        handler:function(){
            if (user.id>0 &&
                actualNodeU.attributes.type=="user"){
                  general.deletion("/users/"+user.id,usersPanel);
            }else{
                Ext.Msg.alert("Error","You must select an user");
            }
        }
    }]
});

var toolBarUsers = new Ext.Toolbar({
    items:[{
        iconCls:"role",
        text:"Roles",
        menu:role_menu
    },{
        iconCls:"user",
        text:"Users",
        menu:user_menu
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
    contextMenu: new Ext.menu.Menu({
        items:[{
            iconCls:"role",
            text:"Roles",
            menu:role_menu
        },{
            iconCls:"user",
            text:"Users",
            menu:user_menu
        }]
    }),
    loader: new Ext.tree.TreeLoader({
        requestMethod:"GET",
        dataUrl:function() {return "/roles";}
    }),
    listeners:{
        click:function(n){
            actualNodeU=n;
            if (n.attributes.type=="role")
                role.id=n.attributes.iddb;
            else if (n.attributes.type=="user")
                user.id=n.attributes.iddb;
        },
        contextmenu: function(node, e) {
//          Register the context node with the menu so that a Menu Item's handler function can access
//          it via its parentMenu property.
            node.select();
            var c = node.getOwnerTree().contextMenu;
            c.contextNode = node;
            c.showAt(e.getXY());
        }
    },
    root: new Ext.tree.AsyncTreeNode()
});

var toolBarRules=new Ext.Toolbar({
    items:[new Ext.form.Checkbox({
            id:"checkbox_create",
            name:"checkbox_create",
            boxLabel:"Create",
            listeners:{
            change:function(n){
                update_priv(n,"privilege[creating]");
           }}}),"-",
           new Ext.form.Checkbox({
               id:"checkbox_read",
               name:"checkbox_read",
               boxLabel:"Read",
               listeners:{
               change:function(n){
                   update_priv(n,"privilege[reading]");
               }}}),"-",
           new Ext.form.Checkbox({
               id:"checkbox_update",
               name:"checkbox_update",
               boxLabel:"Update",
               listeners:{
               change:function(n){
                   update_priv(n,"privilege[updating]");
               }}}),"-",
           new Ext.form.Checkbox({
               id:"checkbox_delete",
               name:"checkbox_delete",
               boxLabel:"Delete",
               listeners:{
               change:function(n){
                   update_priv(n,"privilege[deleting]");
               }}})]
});

update_priv=function(n,field){
    var value=false;
    if (n.getValue()==true && privilege.id>0)
        value=true;
    else if(n.getValue()==false && privilege.id>0)
        value=false;

    var param_text='{"id":'+privilege.id+
                   ',"privilege[role_id]":'+privilege.role_id+
                   ',"privilege[module_id]":'+privilege.module_id+
                   ',"'+field+'":'+value+
                   ',"privilege[module]":'+privilege.module+' }';

    var param_json=JSON.parse(param_text);
    Ext.Ajax.request({
        url:"privileges/update",
        method:"PUT",
        params:param_json
    });
}

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
        },contextmenu: function(node, e) {}
        ,click:function(o){
            for (var i=0;i<7;i++){
                if (toolBarRules.items.items[i].name!=undefined)
                    toolBarRules.items.items[i].setValue(0);
            }
            if (o.id.match(/src:roles/)==null){
                find_role(o);
                Ext.Ajax.request({
                    url:"privileges/show",
                    method:"POST",
                    params:{id:o.attributes.iddb,node:o.id,role_id:role.id},
                    success:function(response){
                        var data=JSON.parse(response.responseText);
                        if (data.errors==undefined){
                            privilege.id=data.data.privilege.id;
                            privilege.module=data.data.privilege.module;
                            privilege.role_id=data.data.privilege.role_id;
                            privilege.module_id=data.data.privilege.module_id;

                            if (data.data.privilege.creating==true)
                                toolBarRules.items.map.checkbox_create.setValue(1);
                            if(data.data.privilege.reading==true)
                                toolBarRules.items.map.checkbox_read.setValue(1);
                            if(data.data.privilege.updating==true)
                                toolBarRules.items.map.checkbox_update.setValue(1);
                            if(data.data.privilege.deleting==true)
                                toolBarRules.items.map.checkbox_delete.setValue(1);
                        }

                    }
                });
            }
        }
    }
});

function find_role(o){
    if (o.id.match(/src:roles/)==null)
        find_role(o.parentNode);
    else
        role.id=o.attributes.iddb;
}

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
    },
    listeners:{contextmenu: function(node, e) {}}
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