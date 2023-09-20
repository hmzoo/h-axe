package axe;

import axe.Params.*;

final color_axes = 0xC0C0C0;
final color_ang = 0x87CEEB;
final color_mir = 0x483D8B;

class Background extends h2d.Object {
	var g:h2d.Graphics;
	var itv:h2d.Interactive;
    var cursor_x:Float=0;
    var cursor_y:Float=0;
    var mirs:Array<Mir>=[];
    var smirid:Int=0;



    var flag_push:Bool=false;

	public function new(scene:h2d.Scene) {
		super(scene);

        for (i in 0...MIR_NUM) {
            mirs.push(new Mir(-SCREEN_WIDTH/2+i*(SCREEN_WIDTH/MIR_NUM),0));
        }

		g = new h2d.Graphics(this);
		g.x = SCREEN_WIDTH/2;
		g.y = SCREEN_HEIGHT/2;
		g.scaleY = -1;

		itv = new h2d.Interactive(SCREEN_WIDTH, SCREEN_HEIGHT, this);
		// itv.x=200;
		// itv.y=200;
		// itv.scaleY=-1;
		itv.onMove = this.onMove;
        itv.onPush = function(e:hxd.Event){flag_push=true;onMove(e);};
        itv.onRelease = function(e:hxd.Event){
            flag_push=false;        
            for ( m in mirs){
            m.lck=false;};
        };

		this.redraw();
	}


    public function drawdraft(m:Mir){


        g.lineStyle(2, color_ang);
		g.moveTo(0, -m.cr);
		g.lineTo(m.cx, m.cy);
		g.lineTo(0, m.cr);

        g.drawCircle(0, 0, m.cr);

        g.lineStyle(0);
		g.endFill();

    }

    public function drawmir(m:Mir){



        g.lineStyle(2, color_mir);
        g.moveTo(m.acx,m.acy);
        g.lineTo(m.bcx,m.bcy);

		g.lineStyle(0);

		g.beginFill(color_mir);
		g.drawCircle(m.bcx, m.bcy, 3, 6);
        g.drawCircle(m.acx, m.acy, 3, 6);

		g.lineStyle(0);
		g.endFill();

    }

	public function redraw() {

        //trace(dx);
		g.clear();

		g.beginFill(0xFFFFFF);
		g.drawRect(-SCREEN_WIDTH/2, -SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT);
        
		g.endFill();

		g.lineStyle(2, color_axes);
		g.moveTo(0, -SCREEN_HEIGHT/2);
		g.lineTo(0, SCREEN_HEIGHT/2);
		g.moveTo(-SCREEN_WIDTH/2, 0);
		g.lineTo(SCREEN_WIDTH/2, 0);

        for (m in mirs){drawdraft(m); }
        for (m in mirs){drawmir(m); }


        // g.beginFill(0xDF1652);
        // g.drawCircle(mirs[0].cx, mirs[0].cy, 8, 6);
        // g.endFill();
        


		
	}

	function onMove(e:hxd.Event) {
        if(flag_push){
		cursor_x = e.relX - SCREEN_WIDTH/2;
		cursor_y = -e.relY + SCREEN_HEIGHT/2;
        
        var d:Float=1000;
        for (k => m in mirs){
            m.lck=false;
            if(m.cdst(cursor_x ,cursor_y)<d){d=m.cdst(cursor_x ,cursor_y);smirid=k;}
        }
        mirs[smirid].calc(cursor_x,cursor_y);
        mirs[smirid].lck=true;
		this.redraw();
        }
	}

    public function update(){
        mirs[0].smooth(null,mirs[1]);
        for (i in 1...MIR_NUM-1) {
            mirs[i].smooth(mirs[i-1],mirs[i+1]);
        }
        mirs[MIR_NUM-1].smooth(mirs[MIR_NUM-2],null);

        for (i in 0...MIR_NUM) {
               mirs[i].dosmooth();
        }
        this.redraw();

    }

    public function tosvg(){
        var svg="<svg width=\"800\" height=\"800\" viewBox=\"-400 -400 800 800\">";

        svg=svg+"<circle cx=\"0\" cy=\"0\" r=\"5\" fill=\"green\" />\n";
        svg=svg+"<path stroke=\"#333333\" stroke-width=\"3\" fill=\"none\" d=\" \n ";
        
        svg=svg+"M "+mirs[0].acx+","+mirs[0].acy+" \n";
        for (i in 1...MIR_NUM) {
            svg=svg+"L "+mirs[i].acx+","+mirs[i].acy+" \n";
        }
        svg=svg+"M "+mirs[MIR_NUM-1].bcx+","+mirs[MIR_NUM-1].bcy+" \" \n";

        svg=svg+"/> \n</svg>";
        return svg;


    }


}
