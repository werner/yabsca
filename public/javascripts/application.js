function loadwindow(path,w,h){
    if (w==undefined)
        w='550px';
    if (h==undefined)
        h='400px';
    window.showModalDialog(path,"",
    "dialogTop=250px;dialogLeft=200px;dialogWidth="+w+"; dialogHeight="+h+"; \n\
    status=no; scroll=no;resizable=no;center=yes;help=no;unadorned=yes;");
}