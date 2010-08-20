var organization=new Object();

organization.id=0;
organization.parent_id=0;
organization.url="";
organization.method="";
organization.form= new Ext.FormPanel({
    labelWidth: 75,
    frame:true,
    title: lang.orgsLabel,
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    defaultType: 'textarea',
    items: [new Ext.form.TextField({
            fieldLabel: lang.nameLabel,
            id:'organization_name',
            name: 'organization[name]',
            allowBlank:false
        }),{
            fieldLabel: lang.visionLabel,
            id:'organization_vision',
            name: 'organization[vision]'
        },{
            fieldLabel: lang.goalLabel,
            id:'organization_goal',
            name: 'organization[goal]'
        }, {
            fieldLabel: lang.descriptionLabel,
            id:'organization_description',
            name: 'organization[description]'
        }, new Ext.form.Hidden({
            id:'organization_organization_id',
            name:'organization[organization_id]'
        })
    ]
});

organization.win= new Ext.Window({
    layout:'fit',
    width:400,
    height:400,
    closeAction:'hide',
    plain: true,
    items:[organization.form],
    buttons:[{
        text:lang.saveLabel,
        iconCls:'save',
        handler: function(){
            organization.form.getForm().submit({
                url:organization.url,
                method:organization.method,
                params:{organization_id:organization.id},
                success: function(){
                    treePanelOrgs.getRootNode().reload();
                    organization.win.hide();
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
            organization.win.hide();
        }
    }]
});