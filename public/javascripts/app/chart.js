var fchart = new FusionCharts("../../FusionCharts/FCF_Column3D.swf",
                "chart1Id", "400", "300", "0", "1");

Ext.Ajax.request({
    url:"/generate_chart",
    method:"GET",
    params:{measure_id: 2},
    success:function(data){
        fchart.setDataXML(data.responseText);
        fchart.render("chart");
    }
});
