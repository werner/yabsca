var organization=new Object();

organization.id=0;
organization.url="";
organization.method="";
organization.form= new Ext.FormPanel({
    labelWidth: 75,
    frame:true,
    title: 'Organization',
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    defaultType: 'textarea',
    items: [new Ext.form.TextField({
            fieldLabel: 'Name',
            id:'organization_name',
            name: 'organization[name]',
            allowBlank:false
        }),{
            fieldLabel: 'Vision',
            id:'organization_vision',
            name: 'organization[vision]'
        },{
            fieldLabel: 'Goal',
            id:'organization_goal',
            name: 'organization[goal]'
        }, {
            fieldLabel: 'Description',
            id:'organization_description',
            name: 'organization[description]'
        }, new Ext.form.Hidden({
            id:'organization_organization_id',
            name:'organization[organization_id]'
        })
    ]
});

organization.treePanel= new Ext.tree.TreePanel({
    id: 'tree-panel_org',
    split: true,
    minSize: 150,
    autoScroll: true,
    rootVisible: false,
    lines: false,
    singleExpand: true,
    useArrows: true,
    animate: true,
    loader:new Ext.tree.TreeLoader({
        dataUrl:'/org_and_strat'
    }),
    listeners:{
        click: function(n){
            organization.id=n.id;
        }
    },
    root: new Ext.tree.AsyncTreeNode()
});

organization.win= new Ext.Window({
    layout:'fit',
    width:400,
    height:400,
    closeAction:'hide',
    plain: true,
    items:[organization.form],
    buttons:[{
        text:'Save',
        handler: function(){
            organization.form.getForm().submit({
                url:organization.url,
                method:organization.method,
                success: function(){
                    organization.treePanel.getRootNode().reload();
                    organization.win.hide();
                },
                failure: function(form, action) {
                    Ext.Msg.alert("Error",
                    "Make sure about all data is correct.");
                }
            });
        }
    },{
        text:'Close',
        handler:function(){
            organization.win.hide();
        }
    }]
});