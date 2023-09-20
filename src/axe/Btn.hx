package axe;

final color_btnfill = 0x72C8FA;
final color_btntext = 0x063B50;
final color_btnborder = 0xBDBDBD;
final btn_width:Float = 100;
final btn_height:Float = 30;

class Btn extends h2d.Object {

    var g:h2d.Graphics;
	var itv:h2d.Interactive;

    var btntext:h2d.Text;

	public function new(text:String,scene:h2d.Scene) {
		super(scene);
        g = new h2d.Graphics(this);
        g.lineStyle(2, color_btnborder);
        g.beginFill(color_btnfill);
		g.drawRect(-0, 0, btn_width, btn_height);
		g.endFill();

        btntext = new h2d.Text(hxd.res.DefaultFont.get(),this);
        btntext.textColor= color_btntext;
        setText(text);

        itv = new h2d.Interactive(btn_width, btn_height, this);
        itv.onRelease = function(e:hxd.Event){ pushed() ;};

      
    }

    public function setText(t) {btntext.text =t;}

    public dynamic function pushed(){
        trace("pushed");
    }








}