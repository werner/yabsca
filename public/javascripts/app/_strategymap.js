Ext.onReady(function() {

    var node="";
    var ob=0;
    var canvas;
    var divCanvas=Ext.get('drawingmap');
    var actualCanvas;

    var toolBar=new Ext.Toolbar({
        region: 'north',
        items:[new Ext.Button({
                text:"New",
                iconCls:"new",
                handler:function(){
//                    ob++;
//                    divCanvas.createChild("<canvas id='drawcanvas"+ob+
//                        "' width='800' height='500'></canvas>");
//                    canvas=Ext.get('drawcanvas'+ob);
//                    drawEllipse(canvas.dom);
//                    canvas.on('click',function(){
//                        actualCanvas=this;
//                    });
//                    canvas.setX(400);
//                    canvas.setY(30);
//                    $("#drawcanvas"+ob).draggable();
                    canvas=Ext.get('drawcanvas');
                    drawEllipse(canvas.dom);
                }
        }),new Ext.Button({
            text:"Delete",
            iconCls:"del",
            handler:function(){
                actualCanvas.remove();
            }
        })]
    });

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
            contextmenu: function(node, e) {},
            click:function(o){
                node=o;
            }
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
        tbar:toolBar,
        items:[everybody]
    });
    
    everyWindows.show();

    function drawEllipse(el) {
        var ctx = el.getContext("2d");

        x=0;
        y=0;
        w=200;
        h=100;
        var kappa = .5522848;
          ox = (w / 2) * kappa, // control point offset horizontal
          oy = (h / 2) * kappa, // control point offset vertical
          xe = x + w,           // x-end
          ye = y + h,           // y-end
          xm = x + w / 2,       // x-middle
          ym = y + h / 2;       // y-middle

        ctx.beginPath();
        ctx.fillStyle = "rgb(50,129,169)";
        ctx.moveTo(x, ym);
        ctx.bezierCurveTo(x, ym - oy, xm - ox, y, xm, y);
        ctx.bezierCurveTo(xm + ox, y, xe, ym - oy, xe, ym);
        ctx.bezierCurveTo(xe, ym + oy, xm + ox, ye, xm, ye);
        ctx.bezierCurveTo(xm - ox, ye, x, ym + oy, x, ym);
        ctx.closePath();
        ctx.fill();
        ctx.fillStyle = "Black";
        ctx.font = 'bold 12px arial';
        ctx.textAlign="center";
        ctx.fillText(node.text, 100, 50,200);

    }
});