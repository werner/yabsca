Ext.onReady(function(){
    var paper = Raphael('treecanvas',800,500);
    Ext.Ajax.request({
      url:"/get_measure_tree",
      method:"GET",
      params:{id: measure_id},
      success:function(data){
          var tree=JSON.parse(data.responseText);
          draw_nodes(tree,400,10);
      } 
    });

    function draw_nodes(tree,x,y){
        var x1=x;
        tree.children.map(function(item){
            var root=paper.text(x1,y,item.name);
            var root_img=paper.image("/images/"+item.color+"_light.png",x1-32,y+10,64,64);
            var conect = paper.path("M"+(x1-32)+" "+(x1-32)+" L"+(y+10)+" "+(y+10));
            x1+=120;
            draw_nodes(item,x,y+120);
        });
    }
});


