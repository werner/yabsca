var measure=new Object();
measure.id=0;
Ext.onReady(function() {

    var node=new Object();
    node.id=0;
    var objective_id=0;
    var paper = Raphael('drawcanvas',800,500);
    Property.paper=paper;
    Ext.Ajax.request({
        url:"/strategies/"+strategy_id+"/edit",
        method:"GET",
        success:function(data){
            var map=JSON.parse(data.responseText);
            if (map.data["strategy[strategy_map]"]!=null){
                var strategyMap=JSON.parse(map.data["strategy[strategy_map]"]);
                paper.serialize.load_json(strategyMap);
            }
        }
    });
    Property.setSelected=paper.set();
    Property.dataSet=paper.set();
    Property.selectedPersp=paper.set();

    var actualText;

    paper.raphael.click(function(event){        
        if (event.target.localName=="svg"){
            if (actualText!=undefined) actualText.attr({stroke:""});
            Property.setSelected.remove();
            if (Property.lrb!=""){
                Property.lrb.remove();
            }
        }else if (event.target.localName=="ellipse"){
            objective_id=event.target.id;
            measuresTree.getRootNode().reload();
        }
    });

    var dataMenu= new Ext.menu.Menu({
        items:[{
                text:lang.newLabel,
                iconCls:"new",
                handler:function(){
                    if (node!=undefined){
                        if (node.attributes.type=="objective"){
                            var dataEllipse = paper.ellipse(110, 80, 100, 40);

                            dataEllipse.attr({"fill": "#6cb6f4"});
                            dataEllipse.node.id=node.attributes.iddb;
                            var dataText = paper.text(110, 70, node.text);
                            dataText.click(function(event){
                               var ob=event.target.parentNode.raphael;
                               actualText=ob;
                               ob.attr({stroke:"black"})
                            });
                            var st=paper.set();
                            st.push(dataEllipse,dataText);
                            var start = function () {
                                this.ox = this.attr("cx");
                                this.oy = this.attr("cy");
                                this.lx = dataText.attr("x");
                                this.ly = dataText.attr("y");
                            },
                            move = function (dx, dy) {
                                this.attr({cx: this.ox + dx, cy: this.oy + dy,
                                            x:this.lx + dx, y: this.ly + dy});
                                dataText.attr({x:this.lx + dx, y: this.ly + dy});
                            };
                            st.drag(move, start);
                            st.click(function(event){
                                Property.actualObject=new Object();
                                Property.dataSet=st;
                                
                               if (event.target.localName=="ellipse"){
                                   Property.transformObject=event.target.raphael;
                                   Property.selectedEllipse(event);
                               }
                            });
                            Property.dataSet.mouseover(function(event){
                               document.body.style.cursor='move';
                            });
                            Property.dataSet.mouseout(function(event){
                               document.body.style.cursor='auto';
                            });
                        }else if (node.attributes.type=="perspective"){
                            var persp=paper.rect(10,10,750,110);
                            var rectl=paper.rect(10,10,750,20);
                            var perspt = paper.text(350, 20, node.text);
                            perspt.attr("font-size","12");
                            rectl.attr("fill", "#18c7c9");
                            var stpersp=paper.set();
                            stpersp.push(persp,rectl,perspt);
                            var pstart = function () {
                                persp.ox = persp.attr("x");
                                persp.oy = persp.attr("y");
                                rectl.ox = rectl.attr("x");
                                rectl.oy = rectl.attr("y");
                                perspt.ox=perspt.attr("x");
                                perspt.oy=perspt.attr("y");
                            },
                            pmove = function (dx, dy) {
                                persp.attr({x: persp.ox + dx, y: persp.oy + dy});
                                rectl.attr({x: rectl.ox + dx, y: rectl.oy + dy});
                                perspt.attr({x:perspt.ox + dx, y: perspt.oy + dy});
                            };
                            stpersp.drag(pmove, pstart);
                            stpersp.click(function(event){
                                Property.actualObject=new Object();
                                Property.selectedPersp=stpersp;
                            });
                            Property.selectedPersp.mouseover(function(event){
                               document.body.style.cursor='move';
                            });
                            Property.selectedPersp.mouseout(function(event){
                               document.body.style.cursor='auto';
                            });
                        }
                    }
                }
        },{
            text:lang.delLabel,
            iconCls:"del",
            handler:function(){
                Property.setSelected.remove();
                Property.dataSet.remove();
                Property.selectedPersp.remove();
                if (!Property.isEmpty(Property.actualObject))
                    Property.actualObject.remove();
            }
        }]

    });

    var drawingObjects=new Ext.menu.Menu({
       items:[{
            text:lang.lineLabel,
            iconCls:"line",
            handler:function(){
                var l = paper.path("M10 10L90 90");
                Property.line(l);
            }
        },{
            text:lang.curveLabel,
            iconCls:"curve",
            handler:function(){
                var c = paper.path("M10,55 C10,5 100,5 100,55");
                Property.curve(c);
            }
        },{
            text:lang.ellipseLabel,
            iconCls:"ellipse",
            handler:function(){
                var ellipse = paper.ellipse(110, 80, 100, 40);
                Property.ellipse(ellipse);
            }
        },{
            text:lang.textLabel,
            iconCls:"text",
            handler:function(){
                Ext.Msg.prompt(lang.textLabel, lang.enterText, function(btn, text){
                    if (btn == 'ok'){
                        var t = paper.text(110, 70, text);
                        Property.text(t);
                    }
                });
            }
        }]
    });

    var editMenu=new Ext.menu.Menu({
        items:[{
            text:lang.cleanCanvas,
            iconCls:"erase",
            handler:function(){
                paper.clear();
            }
        },{
            text:lang.saveCanvas,
            iconCls:"saving",
            handler:function(){
                var raphaelData = paper.serialize.json();
                Ext.Ajax.request({
                    url:"/strategies/"+strategy_id,
                    method:"PUT",
                    params:{"strategy[strategy_map]":raphaelData,strategy_id:strategy_id}
                });
            }
        },{
            text:lang.exportCanvas,
            iconCls:"export",
            handler:function(){
                var canvas=Ext.get("drawcanvas");
                var data=canvas.dom.innerHTML;
                Ext.Ajax.request({
                    url:"/strategies/"+strategy_id,
                    method:"PUT",
                    params:{"strategy[strategy_map_svg]":data,strategy_id:strategy_id},
                    success:function(response){
                        window.location="/export?id="+strategy_id;
                    }
                });
            }
        }]
    });

    var toolBar=new Ext.Toolbar({
        region: 'north',
        items:[{
           text:lang.dataObjects,
           menu:dataMenu
        },{
            text:lang.drawingObjects,
            menu:drawingObjects
        },{
            text:lang.editionLabel,
            menu:editMenu
        }]
    });

    var everybody = new Ext.tree.TreePanel({
        useArrows: true,
        ddGroup: 'dataDDGroup',
        enableDrag:true,
        autoScroll: true,
        animate: true,
        containerScroll: true,
        border: true,
        width:400,
        loader: new Ext.tree.TreeLoader({
            requestMethod:"GET",
            dataUrl: "/strategies.json"
        }),
        root: {
            nodeType: 'async',
            text: lang.perspLabel,
            draggable: false,
            id: 'src:root'
        },
        listeners:{
            contextmenu: function(node, e) {},
            click:function(o){node=o;}
        }
    });

    measureMenu=new Ext.menu.Menu({
           items:[{
               text:lang.chartLabel,
               iconCls:"chart",
               handler:function(){
                    general.graph_win.show();
               }        
        }]
    });

    var measuresTree = new Ext.tree.TreePanel({
        autoScroll: true,
        rootVisible: false,
        lines: false,
        singleExpand: true,
        width:500,
        useArrows: true,
        contextMenu:measureMenu,
        loader: new Ext.tree.TreeLoader({
            requestMethod:"GET",
            dataUrl:function() {return "/measures?objective_id="+objective_id}
        }),
        listeners:{
            click:function(n){
                measure.id=n.id;
            },
            load:function(n){
            },
            contextmenu: function(node, e) {
                node.select();
                var c = node.getOwnerTree().contextMenu;
                c.contextNode = node;
                c.showAt(e.getXY());
            }
        },
        root: new Ext.tree.AsyncTreeNode()
    });


    var everyWindows=new Ext.Window({
        layout:'accordion',
        width:400,
        height:500,
        closable:false,
        x:1,y:30,
        closeAction:'hide',
        plain: true,
        tbar:toolBar,
        items:[{
            title:lang.perspLabel,
            defaults:{border:false, activeTab:0},
            items:[everybody]
        },{
            title: lang.measuresLabel,
            defaults:{border:false, activeTab:0},
            items:[measuresTree]
        }]
    });

    everyWindows.show();

});
