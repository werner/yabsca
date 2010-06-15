var initiative = new Object();

initiative.id=0;
initiative.url="";
initiative.method="";

initiative.form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:"Initiative",
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel: "Name",
        id: "initiative_name",
        name:"initiative[name]",
        allowBlank: false
    }),new Ext.form.TextField({
        fieldLabel: "Code",
        id: "initiative_code",
        name:"initiative[code]"
    }),new Ext.form.NumberField({
        fieldLabel: "Completed",
        id: "initiative_completed",
        name:"initiative[completed]"
    }),new Ext.form.DateField({
        fieldLabel: "Beginning",
        id: "initiative_beginning",
        name:"initiative[beginning]"
    }),new Ext.form.DateField({
        fieldLabel: "End",
        id: "initiative_end",
        name:"initiative[end]"
    }),new Ext.form.ComboBox({
        id:"initiative_responsible_id",
        fieldLabel: "Responsible",
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
        valueNotFoundText:"Select an responsible...",
        emptyText: "Select an responsible..."
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
        text:'Save',
        iconCls:'save',
        handler: function(){
            initiative.form.getForm().submit({
                url:initiative.url,
                method:initiative.method,
                success: function(){
                    initiative.treePanel.getRootNode().reload();
                    initiative.win.hide();
                },
                failure: function() {
                    Ext.Msg.alert("Error",
                    "Make sure about all data is correct.");
                }
            });
        }
    },{
        text:'Close',
        iconCls:'close',
        handler:function(){
            initiative.win.hide();
        }
    }]
});

initiative.toolBar=new Ext.Toolbar({
    items:[{
       text:"Initiatives",
       iconCls:"initiative",
       menu:{
           items:[{
               text: "New",
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
                        Ext.Msg.alert("Error","You must select an objective");
                    }
               }
           },{
               text:"Edit",
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
                        Ext.Msg.alert("Error","You must select an initiative");
                    }
               }
           },{
               text: "Delete",
               iconCls: "del",
               handler:function(){
                    if (initiative.id>0){
                        general.deletion("/initiatives/"+initiative.id,initiative.treePanel);
                    }else{
                        Ext.Msg.alert("Error","You must select an initiative");
                    }
               }
           }]
       }
    },{
       text:"Responsibles",
       iconCls:"responsible",
       handler:function(){
            responsible.win.show();
       }
    }]
});

initiative.treePanel = new Ext.tree.TreePanel({
    id: "tree-panel_i",
    title: "Initiatives",
    region: "center",
    autoScroll: true,
    rootVisible: false,
    singleExpand: true,
    useArrows: true,
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
        }
    },
    root: new Ext.tree.AsyncTreeNode()
});