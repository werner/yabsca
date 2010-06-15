var fchart = new Object();

fchart.type="";

function generate_chart(){
    if (fchart.type=="FCF_Gantt.swf"){
        Ext.Ajax.request({
            url:"/generate_gantt",
            method:"GET",
            params:{objective_id: objective.id},
            success:function(data){
                fchart.column = new FusionCharts("../../FusionCharts/"+fchart.type,
                                "chart1Id", "400", "300", "0", "1");
                fchart.column.setDataXML(data.responseText);
                fchart.column.render("fchart");
            }
        });
    }else{
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
