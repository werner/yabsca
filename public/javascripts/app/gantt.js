Ext.onReady(function(){
    Ext.Ajax.request({
        url:"/generate_gantt",
        params:{objective_id:objective_id},
        method:"GET",
        success:function(response){
            var tasks=new Array();
            var childTasks=new Array();
            var data=JSON.parse(response.responseText);

            var ganttChartControl = new GanttChart();
            ganttChartControl.setImagePath("javascripts/dhtmlxGantt/codebase/imgs/");

            var project = new GanttProjectInfo(data[0].id, data[0].name,
                                             new Date(data[0].startdate));

            for(var i=0;i<data[0].tasks.length;i++){
                 tasks[i] = new GanttTaskInfo(data[0].tasks[i].id, data[0].tasks[i].name,
                                                 new Date(data[0].tasks[i].date), data[0].tasks[i].duration,
                                                 data[0].tasks[i].completed,"");
                 for (var j=0;j<data[0].tasks[i].tasks.length;j++){
                    childTasks[j]=new GanttTaskInfo(data[0].tasks[i].tasks[j].id, data[0].tasks[i].tasks[j].name,
                                                     new Date(data[0].tasks[i].tasks[j].date), data[0].tasks[i].tasks[j].duration,
                                                     data[0].tasks[i].tasks[j].completed);
                    tasks[i].addChildTask(childTasks[j]);
                 }
                 project.addTask(tasks[i]);
            }
            ganttChartControl.showDescTask(true,'d,s-f');    
            ganttChartControl.showDescProject(true,'n,d');    
            ganttChartControl.setEditable(true);   
            ganttChartControl.addProject(project);
            ganttChartControl.create("gantt");
        }
    });
});

