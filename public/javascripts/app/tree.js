Ext.Ajax.request({
    url:"/measures/"+measure_id+"/edit",
    method:"GET",
    params:{id: measure_id},
    success:function(data){
        var measure=JSON.parse(data.responseText);
        function drawChart() {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Label');
            data.addColumn('number', 'Value');
            data.addRows(1);
            data.setValue(0, 0, measure.data["measure[name]"]);
            data.setValue(0, 1, 80);

  var dataLabel = new google.visualization.DataTable();
  dataLabel.addColumn('string', 'Department');
  dataLabel.addColumn('number', 'Revenues');
  dataLabel.addRows([
    ['Shoes', 10700],
    ['Sports', -15400],
    ['Toys', 12500],
    ['Electronics', -2100],
    ['Food', 22600],
    ['Art', 1100]
  ]);

  var table = new google.visualization.Table(document.getElementById('colorformat_div'));
  
  table.draw(dataLabel, {allowHtml: true, showRowNumber: true});

            var chart = new google.visualization.Gauge(document.getElementById('treecanvas'));
            var options = {width: 400, height: 120, redFrom: 90, redTo: 100,
                yellowFrom:75, yellowTo: 90, minorTicks: 5};

            chart.draw(data, options);
        }
	drawChart();
    }
});
