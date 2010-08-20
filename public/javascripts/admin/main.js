var actualNodeU;
var check_set=false;

const Create=1;
const Read=2;
const Update=3;
const Delete=4;

var type="";
var id=0;

Ext.onReady(function() {
    Ext.QuickTips.init();

    var role_menu=new Ext.menu.Menu({
        items:[{
            iconCls:"new",
            text:lang.newLabel,
            handler:function(){
                role.method="POST";
                role.url="roles/create";
                role.form.getForm().reset();
                role.win.show();
            }
        },{
            iconCls:"edit",
            text:lang.editLabel,
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
            text:lang.delLabel,
            handler:function(){
                if (role.id>0 &&
                    actualNodeU.attributes.type=="role"){
                      general.deletion("/roles/"+role.id,usersPanel);
                }else{
                    Ext.Msg.alert("Error",lang.roleSelection);
                }
            }
        }]
    });

    var user_menu = new Ext.menu.Menu({
        items:[{
            iconCls:"new",
            text:lang.newLabel,
            handler:function(){
                if (role.id!=0){
                    user.method="POST";
                    user.url="users/create";
                    user.form.getForm().reset();
                    user.form.items.map.user_role_ids.setValue(role.id);
                    user.win.show();
                }else{
                    Ext.Msg.alert("Error",lang.roleSelection);
                }
            }
        },{
            iconCls:"edit",
            text:lang.editLabel,
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
                    Ext.Msg.alert("Error",lang.userSelection);
                }
            }
        },{
            iconCls:"del",
            text:lang.delLabel,
            handler:function(){
                if (user.id>0 &&
                    actualNodeU.attributes.type=="user"){
                      general.deletion("/users/"+user.id,usersPanel);
                }else{
                    Ext.Msg.alert("Error",lang.userSelection);
                }
            }
        }]
    });

    var toolBarUsers = new Ext.Toolbar({
        items:[{
            iconCls:"role",
            text:lang.rolesLabel,
            menu:role_menu
        },{
            iconCls:"user",
            text:lang.usersLabel,
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
                text:lang.rolesLabel,
                menu:role_menu
            },{
                iconCls:"user",
                text:lang.usersLabel,
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
                if (n.attributes.type=="role"){
                    user.id=0;
                    role.id=n.attributes.iddb;
                }else if (n.attributes.type=="user"){
                    role.id=0;
                    user.id=n.attributes.iddb;
                }
            },
            contextmenu: function(node, e) {
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
                boxLabel:lang.createLabel,
                listeners:{
                check:function(){
                    update_priv();
               }}}),"-",
               new Ext.form.Checkbox({
                   id:"checkbox_read",
                   name:"checkbox_read",
                   boxLabel:lang.readLabel,
                   listeners:{
                   check:function(){
                       update_priv();
                   }}}),"-",
               new Ext.form.Checkbox({
                   id:"checkbox_update",
                   name:"checkbox_update",
                   boxLabel:lang.updateLabel,
                   listeners:{
                   check:function(){
                       update_priv();
                   }}}),"-",
               new Ext.form.Checkbox({
                   id:"checkbox_delete",
                   name:"checkbox_delete",
                   boxLabel:lang.deleteLabel,
                   listeners:{
                   check:function(){
                       update_priv();
                   }}}),"-",
               new Ext.Button({
                   id:"button_eliminate",
                   name:"button_eliminate",
                   iconCls:"del",
                   handler:function(){
                        Ext.Ajax.request({
                            url:"/privileges/destroy",
                            method:"DELETE",
                            params:{id:object_role_id,type:type},
                            success:function(){
                                store.load();
                            }
                        });
                   }
               })]
    });

    update_priv=function(){

        if (object_role_id>0){
            var param_text='{"type":"'+type+'","id":'+object_role_id+
                           ',"creating":'+toolBarRules.items.map.checkbox_create.getValue()+
                           ',"reading":'+toolBarRules.items.map.checkbox_read.getValue()+
                           ',"updating":'+toolBarRules.items.map.checkbox_update.getValue()+
                           ',"deleting":'+toolBarRules.items.map.checkbox_delete.getValue()+' }';

            var param_json=JSON.parse(param_text);
            if (check_set==false){
                Ext.Ajax.request({
                    url:"privileges/update",
                    method:"PUT",
                    params:param_json
                });
            }
        }
    }

    var proxy=new Ext.data.HttpProxy({url:"/roles_privileges",method:"GET"});

    var reader=new Ext.data.JsonReader({
        idProperty: "id",
        root: "data",
        totalProperty: "results",
        fields:[{name:"id"},{name:"name"}]
    });

    function renderIcon(val) {
        return String.format('<img src="../images/role.png"/>',Ext.BLANK_IMAGE_URL);
    }

    var store=new Ext.data.Store({
        proxy:proxy,
        reader:reader,
        autoSave: true
    });


    function clean_options(){
        check_set=true;
        for (var i=0;i<7;i++){
            if (toolBarRules.items.items[i].name!=undefined)
                toolBarRules.items.items[i].setValue(0);

        }
        check_set=false;
    }

    var object_role_id=0;

    var rolesGrid=new Ext.grid.EditorGridPanel({
        region: 'south',
        store:store,
        height:250,
        ddGroup: 'dataDDSelf',
        split: true,
        tbar:[toolBarRules],
        clicksToEdit: 2,
        columns:[{header:"id",dataIndex:"id", hidden:true},
                 {header:"",dataIndex:"",renderer:renderIcon,width:30},
                 {header:lang.nameLabel, dataIndex:"name",width:150}],
        sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
        listeners:{
            rowclick:function(grid,rowIndex,e){
                object_role_id=grid.store.data.items[rowIndex].data.id;
                clean_options();
                Ext.Ajax.request({
                    url:"privileges/show",
                    method:"POST",
                    params:{id:object_role_id,type:type},
                    success:function(response){
                        var data=JSON.parse(response.responseText);
                        if (data.errors==undefined){
                            check_set=true;
                            if (data["data"][type+"_rule"]["creating"]==true)
                                toolBarRules.items.map.checkbox_create.setValue(1);
                            if(data["data"][type+"_rule"]["reading"]==true)
                                toolBarRules.items.map.checkbox_read.setValue(1);
                            if(data["data"][type+"_rule"]["updating"]==true)
                                toolBarRules.items.map.checkbox_update.setValue(1);
                            if(data["data"][type+"_rule"]["deleting"]==true)
                                toolBarRules.items.map.checkbox_delete.setValue(1);
                            check_set=false;
                        }

                    }
                });
            },
            render:function() {
                var dd = new Ext.dd.DropTarget(this.getView().el.dom.childNodes[0].childNodes[1], {
                    ddGroup:'dataDDSelf'
                    ,notifyDrop:function(dd, e, node) {
                        Ext.Ajax.request({
                            url:"/privileges/create",
                            method:"POST",
                            params:{type:type,
                                    id:id,
                                    role_id:node.node.attributes.iddb},
                            success:function(){
                               store.setBaseParam("type",type);
                               store.setBaseParam("id",id);
                               store.load();
                            }
                        });

                    }
                });
            }
        }
    });

    store.load();

    var privPanel = new Ext.tree.TreePanel({
        useArrows: true,
        region: 'center',
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
            text: lang.privilegesLabel,
            draggable: false,
            id: 'src:root'
        },
        listeners:{contextmenu: function(node, e) {},
                   click:function(o){
                       object_role_id=0;
                       clean_options();
                       id=o.attributes.iddb;
                       type=o.attributes.type;
                       store.setBaseParam("type",type);
                       store.setBaseParam("id",id);
                       store.load();
                   }}
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
            title: lang.usersLabel,
            collapsible: true,
            split: true,
            width: 300,
            items:[toolBarUsers,usersPanel]
        },{
            title: lang.privilegesLabel,
            region: 'center',
            split: true,
            layout: 'border',
            items:[privPanel,rolesGrid]
        }]
    });

});
