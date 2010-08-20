var initiative = new Object();

initiative.id=0;
initiative.url="";
initiative.method="";

initiative.form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:lang.initiativeLabel,
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel: lang.nameLabel,
        id: "initiative_name",
        name:"initiative[name]",
        allowBlank: false
    }),new Ext.form.TextField({
        fieldLabel: lang.codeLabel,
        id: "initiative_code",
        name:"initiative[code]"
    }),new Ext.form.NumberField({
        fieldLabel: lang.completedLabel,
        id: "initiative_completed",
        name:"initiative[completed]"
    }),new Ext.form.DateField({
        fieldLabel: lang.begLabel,
        id: "initiative_beginning",
        name:"initiative[beginning]"
    }),new Ext.form.DateField({
        fieldLabel: lang.endLabel,
        id: "initiative_end",
        name:"initiative[end]"
    }),new Ext.form.ComboBox({
        id:"initiative_responsible_id",
        fieldLabel: lang.respLabel,
        name: "initiative[responsible_id]",
        store: responsible.store,
        displayField: "name",
        valueField: "id",
        hiddenName:"initiative[responsible_id]",
        typeAhead: true,
        triggerAction: 'all',
        forceSelection: true,
        selectOnFocus:true,
        mode: "remote",
        valueNotFoundText:lang.emptyResp,
        emptyText: lang.emptyResp
    }),new Ext.form.Hidden({
        id:"initiative_objective_id",
        name:"initiative[objective_id]"
    }),new Ext.form.Hidden({
        id:"initiative_initiative_id",
        name:"initiative[initiative_id]"
    })]
});

initiative.win=new Ext.Window({
    layout:'fit',
    width:400,
    height:300,
    closeAction:'hide',
    plain: true,
    items:[initiative.form],
    buttons:[{
        text:lang.saveLabel,
        iconCls:'save',
        handler: function(){
            initiative.form.getForm().submit({
                url:initiative.url,
                method:initiative.method,
                params:{objective_id:objective.id},
                success: function(){
                    initiative.treePanel.getRootNode().reload();
                    initiative.win.hide();
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
            initiative.win.hide();
        }
    }]
});

initiative.menuInitiative=new Ext.menu.Menu({
       items:[{
           text: lang.newLabel,
           iconCls: "new",
           handler:function(){
                if (objective.id>0){
                    initiative.method="POST";
                    initiative.url="initiatives/create";
                    initiative.form.getForm().reset();
                    initiative.form.items.map.initiative_objective_id.
                        setValue(objective.id);
                    initiative.form.items.map.initiative_initiative_id.
                        setValue(initiative.id);
                    initiative.win.show();
                }else{
                    Ext.Msg.alert("Error",lang.objSelection);
                }
           }
       },{
           text:lang.editLabel,
           iconCls: "edit",
           handler:function(){
               if (initiative.id>0){
                   initiative.method="PUT";
                   initiative.url="/initiatives/"+initiative.id;
                   initiative.form.getForm().load(
                        {method:'GET',
                         url:'/initiatives/'+initiative.id+'/edit'});
                   initiative.win.show();
                }else{
                    Ext.Msg.alert("Error",lang.initiativeSelection);
                }
           }
       },{
           text: lang.delLabel,
           iconCls: "del",
           handler:function(){
                if (initiative.id>0){
                    general.deletion("/initiatives/"+initiative.id,
                        initiative.treePanel,{objective_id:objective.id});
                }else{
                    Ext.Msg.alert("Error",lang.initiativeSelection);
                }
           }
       }]
});

initiative.toolBar=new Ext.Toolbar({
    items:[{
       text:lang.initiativeLabel,
       iconCls:"initiative",
       menu:initiative.menuInitiative
    },{
       text:lang.respsLabel,
       iconCls:"responsible",
       handler:function(){
            responsible.win.show();
       }
    }]
});

initiative.treePanel = new Ext.tree.TreePanel({
    id: "tree-panel_i",
    title: lang.initiativeLabel,
    region: "center",
    autoScroll: true,
    rootVisible: false,
    singleExpand: true,
    useArrows: true,
    contextMenu:initiative.menuInitiative,
    tbar:[initiative.toolBar],
    loader: new Ext.tree.TreeLoader({
        requestMethod:"GET",
        dataUrl:function() {return "/initiatives?objective_id="+objective.id}
    }),
    listeners:{
        click:function(n){
            initiative.id=n.id;
        },
        load:function(n){
            initiative.id=0;
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