
Ext.onReady(function() {

    var posX=0;
    var posY=0;
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

    var everyWindows=new Ext.Window({
        layout:"fit",
        width:400,
        height:500,
        closable:false,
        x:1,y:30,
        closeAction:"hide",
        plain: true,
        items:[everybody]
    });
    
    everyWindows.show();

    var divCanvas=Ext.get('drawingmap');
    var canvas=Ext.get('drawcanvas');
    canvas.dd=new Ext.dd.DDProxy('drawcanvas', 'ddGroup');
 
    divCanvas.on('click',function(){
        draw(canvas.dom);
        canvas.setX(posX);
        canvas.setY(posY);
    });

    divCanvas.on('mousemove',function(e){
        posX=e.browserEvent.clientX;
        posY=e.browserEvent.clientY;
    });

    function draw(el) {
        var ctx = el.getContext("2d");

        //draw a circle
        ctx.beginPath();
        ctx.fillStyle = "rgb(50,129,169)";
        ctx.arc(70, 70, 70, 0, Math.PI*2, true);
        ctx.closePath();
        ctx.fill();

    }
});