var fchart = new Object();

fchart.type="";

function generate_chart(){
    Ext.Ajax.request({
        url:"/generate_chart",
        method:"GET",
        params:{measure_id: measure.id},
        success:function(data){
            fchart.column = new FusionCharts("../../FusionCharts/"+fchart.type,
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
        text:lang.generateChart,
        iconCls:"save",
        handler: function(){
            generate_chart();
        }
    },{
        text:lang.closeLabel,
        iconCls:'close',
        handler:function(){
            fchart.win.hide();
        }
    }],
    listeners:{
        show:function(){
            generate_chart();
        }
    }
});
