package axe;

import axe.Params.*;

class Mir {
	public var cl:Float = MIR_WIDTH;
	public var cx:Float;
	public var cy:Float;
	public var acx:Float;
	public var acy:Float;
	public var bcx:Float;
	public var bcy:Float;
	public var cr:Float;
	public var lck:Bool;
	public var tx:Float;
	public var ty:Float;

	public function new(x:Float, y:Float) {
		calc(x, y);
	}

	public function calc(x:Float, y:Float) {
		cx = x;
		cy = y;
		cr = Math.sqrt(cx * cx + cy * cy);
		if (x != 0) {
			var ca = (cy + cr) / (cx - 0);
			var dx = Math.sqrt(cl * cl / (1 + ca * ca));
			var dy = dx * ca;
			acx = cx - dx;
			acy = cy - dy;
			bcx = cx + dx;
			bcy = cy + dy;
		} else {
			acx = -cl;
			bcx = cl;
		}
	}

	public function cdst(x:Float, y:Float) {
		var dx = cx - x;
		var dy = cy - y;
		return Math.sqrt(dx * dx + dy * dy);
	}

	public function adst(x:Float, y:Float) {
		var dx = acx - x;
		var dy = acy - y;
		return Math.sqrt(dx * dx + dy * dy);
	}

	public function smooth(ma:Mir, mb:Mir) {
		var s = 2;
		var dtx:Float = 0;
		var dty:Float = 0;
		// var dtx= (ma.bcx-acx)+(mb.acx-bcx);
		// var dty= (ma.bcy-acy)+(mb.acy-bcy);
		// var dtx= (ma.bcx-acx);
		// var dty= (ma.bcy-acy);
		if (ma != null) {
			dtx = ma.bcx - acx;
			dty = ma.bcy - acy;
		}
		if (mb != null) {
			dtx = dtx + mb.acx - bcx;
			dty = dty + mb.acy - bcy;
		}

		tx = cx + dtx / s;
		ty = cy + dty / s;

		// if(!m.lck){
		//     m.tx=m.cx+(bcx-m.acx)/s;
		//     m.ty=m.cy+(bcy-m.acy)/s;
		// }
	}

	public function dosmooth() {
		if (!lck) {
			calc(tx, ty);
		}
	}
}
