var fchart = new Object();

Ext.Ajax.request({
    url:"/generate_chart",
    method:"GET",
    params:{measure_id: measure_id,date_from:date_from,
            date_to:date_to,proj_options:proj_options},
    success:function(data){
        if (proj_options=='yes')
            fchart.column = new FusionCharts("../../FusionCharts/FCF_MSColumn3DLineDY.swf",
                            "chart1Id", "800", "600", "0", "1");
        else if (proj_options=='no')
            fchart.column = new FusionCharts("../../FusionCharts/FCF_Column3D.swf",
                            "chart1Id", "800", "600", "0", "1");
        fchart.column.setDataXML(data.responseText);
        fchart.column.render("fchart");
    }
});

