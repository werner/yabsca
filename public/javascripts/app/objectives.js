var objective = new Object();

objective.id=0
objective.parent_id=0;
objective.url=""
objective.method=""
objective.form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:"Objective",
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel:"Name",
        id:"objective_name",
        name:"objective[name]",
        allowBlank: false
    }),new Ext.form.Hidden({
        id:'objective_perspective_id',
        name:'objective[perspective_id]'
    }),new Ext.form.Hidden({
        id:'objective_objective_id',
        name:'objective[objective_id]'
    })]
});

objective.win=new Ext.Window({
    layout:'fit',
    width:400,
    height:200,
    closeAction:'hide',
    plain: true,
    items:[objective.form],
    buttons: [{
        text:'Save',
        iconCls:'save',
        handler: function(){
            objective.form.getForm().submit({
                url:objective.url,
                method:objective.method,
                params:{perspective_id:perspective.id,objective_id:objective.id},
                success: function(){
                    treePanelPersp.getRootNode().reload();
                    objective.win.hide();
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
            objective.win.hide();
        }
    }]
});