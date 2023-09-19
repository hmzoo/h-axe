package;
import axe.*;



class  MainApp  extends hxd.App {

 
  
    var infos:h2d.Text;
    var background:axe.Background;


 

    override  function  init() {

        hxd.Res.initEmbed();
       // hxd.Window.getInstance().addResizeEvent(this.onResize);
   
        infos = new h2d.Text(hxd.res.DefaultFont.get());
        infos.text = "Hello";
        s2d.scaleMode = Resize;
        s2d.addChild(infos);

        background=new Background(s2d);
 


        

    }

    override function update(dt:Float) {
        var w = hxd.Window.getInstance().width;
		var h = hxd.Window.getInstance().height;
        //infos.text="Size :"+w+" X "+h;   
        
    }

    override function onResize() {
        super.onResize();
        var w = hxd.Window.getInstance().width;
		var h = hxd.Window.getInstance().height;
        infos.text="Size :"+w+" X "+h;
        
        
    }


    public static var inst : MainApp;

    static  function  main() {
        inst=new  MainApp();
    }
  }