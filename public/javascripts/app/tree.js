var r = Raphael("treecanvas", 800, 500);

g1 = new wso2vis.ctrls.CGauge()
        .dialRadius(30)
        .smallTick(2)
        .largeTick(50)
        .minVal(0)
        .maxVal(100)
        .ltlen(15) 
        .stlen(5) 
        .needleCenterRadius(1) 
        .needleBottom(10) 
        .labelOffset(10) 
        .labelFontSize(10) 
        .create(r, 50, 50);

lb1 = new wso2vis.ctrls.Label() 
        .text("Measure") 
        .fontsize(10) 
        .create(r, 110, 50); 

