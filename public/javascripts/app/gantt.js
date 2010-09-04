Ext.onReady(function(){
    Ext.Ajax.request({
        url:"/generate_gantt",
        params:{objective_id:objective_id},
        method:"GET",
        success:function(response){
            var tasks=new Array();
            var projects=new Array();
            var data=JSON.parse(response.responseText);

            var ganttChartControl = new GanttChart();
            ganttChartControl.setImagePath("javascripts/dhtmlxGantt/codebase/imgs/");
            ganttChartControl.setEditable(true);
            for(var i=0;i<data.length;i++){
                 projects[i] = new GanttProjectInfo(data[i].id, data[i].name,
                                                 new Date(data[i].startdate),data[i].duration,
                                                 data[i].completed);
                 for (var j=0;j<data[i].tasks.length;j++){
                    tasks[j]=new GanttTaskInfo(data[i].tasks[j].id, data[i].tasks[j].name,
                                new Date(data[i].tasks[j].date), data[i].tasks[j].duration,
                                data[i].tasks[j].completed);
                    projects[i].addTask(tasks[j]);
                 }
	            ganttChartControl.addProject(projects[i]);
            }
            ganttChartControl.create("gantt");
        }
    });
});
