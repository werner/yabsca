var everybody = new Ext.tree.TreePanel({
    useArrows: true,
    region: 'west',
    ddGroup: 'dataDDGroup',
    enableDrag:true,
    autoScroll: true,
    animate: true,
    containerScroll: true,
    border: true,
    width:400,
    loader: new Ext.tree.TreeLoader({
        requestMethod:"GET",
        dataUrl: "/everything"
    }),
    root: {
        nodeType: 'async',
        text: 'Privileges',
        draggable: false,
        id: 'src:root'
    },
    listeners:{
        contextmenu: function(node, e) {}
    }
});

var viewport = new Ext.Viewport({
    id:'viewport',
    layout: 'border',
    items: [{
        xtype: 'box',
        region: 'north',
        applyTo: 'header',
        height: 27
    }, {
        region: 'west',
        title: 'Data',
        collapsible: true,
        split: true,
        width: 300,
        items:[everybody]
    }, {
        region: 'center',
        split: true,
        layout: 'border',
        width: 200,
        items:[{
            xtype: 'box',
            region: 'center',
            autoEl: {
                tag:'canvas'
            },
            listeners:{
                render:{
                    scope:this,
                    fn:function(n){
                        var dropTarget = new Ext.dd.DropTarget(n.container.dom,{
                          ddGroup: 'dataDDGroup',
                          copy: true,
                          overClass: 'over',
                          notifyDrop: function(dragSource, event, data){
                              draw(this.el.dom.children[0],event.getXY()[0],event.getXY()[1]);
//                              console.log(dragSource);
//                              console.log(event.getXY());
                          }
                        });
                        
                    }
                },
                click:{
                    scope:this,
                    fn: function(e){
                        console.log(e);
                    }
                }
            }   
        }]
    }]
});

function draw(el,x,y) {
    var canvas = el;
    var ctx = canvas.getContext("2d");

    ctx.fillStyle = "red";

    ctx.beginPath();
    ctx.fillStyle = "rgb(50,129,169)";
    ctx.arc(25, 25, 20, 0, Math.PI*2, true);
    ctx.closePath();
    ctx.fill();

}

