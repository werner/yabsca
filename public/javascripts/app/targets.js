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

target.grid=new Ext.grid.EditorGridPanel({
    region: 'center',
    store:target.store,
    clicksToEdit: 2,
    columns:[{header:"id",dataIndex:"id", hidden:true},
             {header:"Period", dataIndex:"period",width:150},
             {header:"Goal", dataIndex:"goal"},
             {header:"Achieved", dataIndex:"achieved"}]
});