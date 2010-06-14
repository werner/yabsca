var fchart = new Object();

function generate_chart(){
    Ext.Ajax.request({
        url:"/generate_chart",
        method:"GET",
        params:{measure_id: measure.id},
        success:function(data){
            fchart.column = new FusionCharts("../../FusionCharts/FCF_Column3D.swf",
                            "chart1Id", "400", "300", "0", "1");
            fchart.column.setDataXML(data.responseText);
            fchart.column.render("fchart");
        }
    });
}

fchart.win=new Ext.Window({
    layout:"fit",
    width:450,
    height:400,
    closeAction:"hide",
    plain: true,
    autoLoad:"/chart",
    buttons:[{
        text:"Generate Chart",
        iconCls:"save",
        handler: function(){
            generate_chart();
        }
    },{
        text:'Close',
        iconCls:'close',
        handler:function(){
            fchart.win.hide();
        }
    }],
    listeners:{
        show:function(n){
            generate_chart();
        }
    }
});
