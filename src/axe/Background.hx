package axe;

final color_axes = 0xC0C0C0;
final color_ang = 0x87CEEB;
final color_mir = 0x483D8B;

class Background extends h2d.Object {
	var g:h2d.Graphics;
	var itv:h2d.Interactive;
    var cx:Float=0;
    var cy:Float=0;
    var points:Array<h2d.col.Point>=[];



    var flag_push:Bool=false;

	public function new(scene:h2d.Scene) {
		super(scene);

        for (i in 0...6) {
            points.push(new h2d.col.Point(-100+i*50,0));
        }

		g = new h2d.Graphics(this);
		g.x = 200;
		g.y = 200;
		g.scaleY = -1;

		itv = new h2d.Interactive(400, 400, this);
		// itv.x=200;
		// itv.y=200;
		// itv.scaleY=-1;
		itv.onMove = this.onMove;
        itv.onPush = function(e:hxd.Event){flag_push=true;onMove(e);};
        itv.onRelease = function(e:hxd.Event){flag_push=false;};

		this.redraw();
	}


    public function drawmir(ccx:Float,ccy:Float){

        var cl:Float=30;
        var cr = dst(ccx, ccy);
        var ra = rap(0,-cr,ccx,ccy);
        var dx=Math.sqrt(cl*cl/(1+ra*ra));

        g.lineStyle(2, color_ang);
		g.moveTo(0, -cr);
		g.lineTo(ccx, ccy);
		g.lineTo(0, cr);

        g.lineStyle(2, color_mir);
        g.moveTo(ccx-dx,ccy-dx*ra);
        g.lineTo(ccx+dx,ccy+dx*ra);

		g.lineStyle(0);

		g.beginFill(0x333333);
		g.drawCircle(ccx, ccy, 3, 6);
		g.endFill();

    }
	public function redraw() {

        //trace(dx);
		g.clear();

		g.beginFill(0xFFFFFF);
		g.drawRect(-200, -200, 400, 400);
		g.endFill();

		g.lineStyle(2, color_axes);
		g.moveTo(0, -200);
		g.lineTo(0, 200);
		g.moveTo(-200, 0);
		g.lineTo(200, 0);

        
        for (p in points){drawmir(p.x,p.y); }
        
        drawmir(cx,cy);

		
	}

	function onMove(e:hxd.Event) {
        if(flag_push){
		cx = e.relX - 200;
		cy = -e.relY + 200;
        var i:Int =0;
        var d:Float=1000;
        for (k => p in points){
            if(dst(cx-p.x,cy-p.y)<d){d=dst(cx-p.x,cy-p.y);i=k;}
        }
        points[i].x=cx;
        points[i].y=cy;

		this.redraw();
        }
	}

	function dst(x:Float, y:Float) {
		return Math.sqrt(x * x + y * y);
	}

    function rap(xa:Float,ya:Float,xb:Float,yb:Float){
        return (yb-ya)/(xb-xa);
    }
}
