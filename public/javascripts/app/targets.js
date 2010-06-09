var target = new Object();

target.id=0;
target.url="";
target.method="";

target.proxy=new Ext.data.HttpProxy({url:"/targets",method:"GET"});

target.reader=new Ext.data.JsonReader({
    idProperty: "id",
    root: "data",
    totalProperty: "results",
    fields:[{name:"id"},{name:"period"},{name:"goal"},{name:"achieved"}]
});

target.store=new Ext.data.Store({
    proxy:target.proxy,
    reader:target.reader,
    autoSave: true
});

target.store.load();

target.toolBar=new Ext.Toolbar({
    items:[{
        text:"New",
        iconCls:"new",
        handler:function(){
            var u = new target.grid.store.recordType({period:'',goal:'',achieved:''});
            target.id=0;
            target.url="/targets/create";
            target.method="POST";
            target.grid.stopEditing();
            target.grid.store.insert(0,u);
            target.grid.startEditing(0,1);
        }
    },{
        text:"Edit",
        iconCls:"edit"
    },{
        text:"Delete",
        iconCls:"del"
    }]
});

target.grid=new Ext.grid.EditorGridPanel({
    region: 'center',
    store:target.store,
    clicksToEdit: 2,
    tbar:[target.toolBar],
    columns:[{header:"id",dataIndex:"id", hidden:true},
             {header:"Period", dataIndex:"period",width:150,
                 editor: new Ext.form.TextField({
                    allowBlank: false
                })},
             {header:"Goal", dataIndex:"goal",editor:new Ext.form.TextField({})},
             {header:"Achieved", dataIndex:"achieved",editor:new Ext.form.TextField({})}]
});
