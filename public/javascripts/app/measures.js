var measure = new Object();

measure.id=0;
measure.url="";
measure.method="";

measure.frecuency_store=new Ext.data.ArrayStore({
   fields: ["id","name"],
   data: [[1,"weekly"],[2,"monthly"],[3,"bimonthly"],
          [4,"three-monthly"],[5,"four-monthly"],[6,"yearly"]]
});

measure.challenge_store=new Ext.data.ArrayStore({
   fields: ["id","name"],
   data: [[1,"increasing"],[2,"decreasing"]]
});

measure.form=new Ext.FormPanel({
    labelWidth:75,
    frame:true,
    title:"Measure",
    bodyStyle:'padding:5px 5px 0',
    width: 350,
    defaults: {width: 230},
    items:[new Ext.form.TextField({
        fieldLabel: "Name",
        id: "measure_name",
        name:"measure[name]",
        allowBlank: false
    }),new Ext.form.TextField({
        fieldLabel: "Code",
        id: "measure_code",
        name:"measure[code]"
    }), new Ext.form.TextArea({
        fieldLabel: "Description",
        id: "measure_description",
        name: "measure[description]"
    }), new Ext.form.ComboBox({
        fieldLabel: "Challenge",
        displayField: "name",
        valueField: "id",
        hiddenName:"measure[challenge]",
        name: "measure[challenge]",
        typeAhead: true,
        store: measure.challenge_store,
        mode: "local",
        forceSelection: true,
        triggerAction: 'all',
        selectOnFocus:true,
        valueNotFoundText:"Select a challenge...",
        emptyText: "Select a challenge..."
    }), new Ext.form.NumberField({
        fieldLabel: "Satisfactory",
        id: "measure_satisfactory",
        name: "measure[satisfactory]"
    }), new Ext.form.NumberField({
        fieldLabel: "Alert",
        id: "measure_alert",
        name: "measure[alert]"
    }), new Ext.form.ComboBox({
        fieldLabel: "Frecuency",
        displayField: "name",
        valueField: "id",
        hiddenName:"measure[frecuency]",
        name: "measure[frecuency]",
        typeAhead: true,
        store: measure.frecuency_store,
        mode: "local",
        forceSelection: true,
        triggerAction: 'all',
        selectOnFocus:true,
        valueNotFoundText:"Select a frecuency...",
        emptyText: "Select a frecuency..."
    }), new Ext.form.DateField({
        fieldLabel: "From",
        id: "measure_period_from",
        name:"measure[period_from]"
    }), new Ext.form.DateField({
        fieldLabel: "To",
        id: "measure_period_to",
        name:"measure[period_to]"
    }), new Ext.form.ComboBox({
        fieldLabel: "Unit",
        name: "measure[unit_id]",
        store: unit.store,
        displayField: "name",
        valueField: "id",
        hiddenName:"measure[unit_id]",
        typeAhead: true,
        triggerAction: 'all',
        forceSelection: true,
        selectOnFocus:true,
        mode: "remote",
        valueNotFoundText:"Select an unit...",
        emptyText: "Select an unit..."
    }),new Ext.form.Hidden({
        id:"measure_objective_ids",
        name:"measure[objective_ids][]"
    })]
});

measure.win=new Ext.Window({
    layout:'fit',
    width:400,
    height:500,
    closeAction:'hide',
    plain: true,
    items:[measure.form],
    buttons:[{
        text:'Save',
        iconCls:'save',
        handler: function(){
            measure.form.getForm().submit({
                url:measure.url,
                method:measure.method,
                success: function(){
                    treePanelM.getRootNode().reload();
                    measure.win.hide();
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
            measure.win.hide();
        }
    }]
});