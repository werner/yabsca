Ext.onReady(function(){
    var paper = Raphael('treecanvas',800,500);
    Ext.Ajax.request({
      url:"/get_measure_tree",
      method:"GET",
      params:{id: measure_id},
      success:function(data){
          var tree=JSON.parse(data.responseText);
          console.log(tree); 
          var root_img=paper.image("/images/red_light.png",336,20,64,64);
          var root=paper.text(400,10,tree.children[0].name);
          //Ext.get('treecanvas').dom.innerHTML=measure.root[0].measure.name;
      } 
    });
});


