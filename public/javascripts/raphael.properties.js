
Property={
    actualObject:new Object(),
    transformObject:new Object(),
    setSelected:new Object(),
    lt:new Object(),lb:new Object(),rt:new Object(),rb: new Object(),lrb: "",
    paper:new Object(),
    actualSet:new Object(),
    text:function(t){
        t.draggable();
        t.mouseover(function(event){
           document.body.style.cursor='move';
        });
        t.mouseout(function(event){
           document.body.style.cursor='auto';
        });
    },
    line:function(l){
        l.attr("stroke-width","2.5");
        l.click(function(event){
            var object=event.target.raphael;
            Property.actualObject=object;
            if (Property.lrb!="") Property.lrb.remove();
            Property.lrb=this.paper.circle(object.attr("path")[1][1],object.attr("path")[1][2],4);
            Property.lrb.attr("fill", "#34ae48");
            //dragging of the points
            var lrbStart = function () {
                this.ox = this.attr("cx");
                this.oy = this.attr("cy");
                this.m="M"+object.attr("path")[0][1]+" "+object.attr("path")[0][2];
                this.lx = object.attr("path")[1][1];
                this.ly = object.attr("path")[1][2];
            },
            lrbMove = function (dx, dy) {
                this.attr({cx: this.ox + dx, cy: this.oy + dy});
                object.attr({path: this.m+"L"+(this.lx + dx)+" "+(this.ly + dy)});
            };
            Property.lrb.drag(lrbMove, lrbStart);
        });
        l.mouseover(function(event){
           document.body.style.cursor='move';
        });
        l.mouseout(function(event){
           document.body.style.cursor='auto';
        });
        l.draggable();
    },
    curve:function(c){
        c.attr("stroke-width","2.5");
        c.click(function(event){
            var object=event.target.raphael;
            Property.actualObject=object;
            Property.setSelected.remove();

            this.lt=this.paper.circle(object.attr("path")[1][1],object.attr("path")[1][2],4);
            this.lb=this.paper.circle(object.attr("path")[0][1],object.attr("path")[0][2],4);
            this.rt=this.paper.circle(object.attr("path")[1][3],object.attr("path")[1][4],4);
            this.rb=this.paper.circle(object.attr("path")[1][5],object.attr("path")[1][6],4);

            this.lt.name="leftTop";
            this.lb.name="leftBottom";
            this.rt.name="rightTop";
            this.rb.name="rightBottom";

            Property.setSelected.push(this.lt,this.lb,this.rt,this.rb);
            Property.actualSet=Property.setSelected;
            Property.setSelected.attr("fill", "#34ae48");
            //dragging of the points
            var rbStart = function () {
                this.ox = this.attr("cx");
                this.oy = this.attr("cy");
            },
            rbMove = function (dx, dy) {
                this.attr({cx: this.ox + dx, cy: this.oy + dy});
                if (this.name=="leftTop")
                    object.attr({path: object.attr("path")[0]+
                            "C"+(this.ox + dx)+","+(this.oy + dy)+
                            " "+object.attr("path")[1][3]+","+object.attr("path")[1][4]+
                            " "+object.attr("path")[1][5]+","+object.attr("path")[1][6]});
                else if (this.name=="leftBottom")
                    object.attr({path: "M"+(this.ox + dx)+","+(this.oy + dy)+
                                    object.attr("path")[1]});
                else if (this.name=="rightTop")
                    object.attr({path: object.attr("path")[0]+
                            "C"+object.attr("path")[1][1]+","+object.attr("path")[1][2]+
                            " "+(this.ox + dx)+","+(this.oy + dy)+
                            " "+object.attr("path")[1][5]+","+object.attr("path")[1][6]});
                else if (this.name=="rightBottom")
                    object.attr({path: object.attr("path")[0]+
                            "C"+object.attr("path")[1][1]+","+object.attr("path")[1][2]+
                            " "+object.attr("path")[1][3]+","+object.attr("path")[1][4]+
                            " "+(this.ox + dx)+","+(this.oy + dy)});

            };
            Property.setSelected.drag(rbMove, rbStart);
        });
        c.draggable();
        c.mouseover(function(event){
           document.body.style.cursor='move';
        });
        c.mouseout(function(event){
           document.body.style.cursor='auto';
        });
    },
    selectedEllipse: function(event){
        var attribs=event.target.raphael.attrs;
        this.setSelected.remove();

        this.lt=this.paper.circle(attribs.cx-attribs.rx,attribs.cy-attribs.ry,4);
        this.lb=this.paper.circle(attribs.cx-attribs.rx,attribs.cy+attribs.ry,4);
        this.rt=this.paper.circle(attribs.cx+attribs.rx,attribs.cy-attribs.ry,4);
        this.rb=this.paper.circle(attribs.cx+attribs.rx,attribs.cy+attribs.ry,4);

        var rbStart = function () {
            this.ox = this.attr("cx");
            this.oy = this.attr("cy");
        },
        rbMove = function (dx, dy) {
            this.attr({cx: this.ox + dx, cy: this.oy + dy});
            Property.transformObject.attr({ry:Property.transformObject.attrs.ry+(dy*0.1),
                                  rx:Property.transformObject.attrs.rx+(dx*0.1)});
        };
        this.rb.drag(rbMove, rbStart);
        this.setSelected.push(this.lt,this.lb,this.rt,this.rb);
        this.actualSet=this.setSelected;
        this.setSelected.attr("fill", "#34ae48");
    },
    ellipse: function(ellipse){
        this.actualObject=ellipse;
        ellipse.attr("fill", "#6cb6f4");
        ellipse.click(function(event){
           if (event.target.localName=="ellipse"){
               Property.transformObject=event.target.raphael;
               Property.selectedEllipse(event);
           }
        });
        var start = function () {
            this.ox = this.attr("cx");
            this.oy = this.attr("cy");
        },
        move = function (dx, dy) {
            this.attr({cx: this.ox + dx, cy: this.oy + dy,
                        x:this.lx + dx, y: this.ly + dy});
        };
        ellipse.drag(move, start);
        ellipse.mouseover(function(event){
           document.body.style.cursor='move';
        });
        ellipse.mouseout(function(event){
           document.body.style.cursor='auto';
        });
    }
}