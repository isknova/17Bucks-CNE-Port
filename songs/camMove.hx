//change this ones//
var camMovement:Int = 20;
var velocity:Int = 3;

//leave this ones alone//
var campoint:FlxPoint;
var camlockpos:FlxPoint;
var camlock:Bool = false;
var camon:Bool = true;
var speed:Float = 1;
var timer:Float = 0;
var curTarget:Int;

function create() {
	campoint = new FlxPoint(0, 0);
	camlockpos = new FlxPoint(0, 0);
}

function postUpdate(elapsed:Float) {
	if (camon && curCameraTarget != curTarget) {
		switch(curCameraTarget) {
			case 0:
				campoint = FlxPoint.get(camFollow.x, camFollow.y);
				camlock = false;
				speed = 1;

			case 1:
				campoint = FlxPoint.get(camFollow.x, camFollow.y);
				camlock = false;
				speed = 1;
		}
		curTarget = curCameraTarget;
	}

	if (timer >= 0) {
		timer -= elapsed;
	} else {
		if (camon) {
			speed = 1;
			camFollow.setPosition(campoint.x, campoint.y);
			camlock = false;
		}
	}

	if (camlock && camon)
		camFollow.setPosition(camlockpos.x, camlockpos.y);

	FlxG.camera.followLerp = FlxMath.bound(elapsed * 2.4 * speed / (FlxG.updateFramerate / 60), 0, 1);
}

function onPlayerHit(_) {
	if (camon) {
		if (curCameraTarget == 1) {
			camlockpos = FlxPoint.get(campoint.x, campoint.y);
			switch(_.direction) {
				case 0:
					camlockpos.x = campoint.x - camMovement;
					camlockpos.y = campoint.y;
				case 1:
					camlockpos.x = campoint.x;
					camlockpos.y = campoint.y + camMovement;
				case 2:
					camlockpos.x = campoint.x;
					camlockpos.y = campoint.y - camMovement;
				case 3:
					camlockpos.x = campoint.x + camMovement;
					camlockpos.y = campoint.y;
			}
			speed = velocity;
			timer = 1;
			camlock = true;
		}
	}
}

function onDadHit(_) {
	if (camon) {
		if (curCameraTarget == 0) {
			camlockpos = FlxPoint.get(campoint.x, campoint.y);
			switch(_.direction) {
				case 0:
					camlockpos.x = campoint.x - camMovement;
					camlockpos.y = campoint.y;
				case 1:
					camlockpos.x = campoint.x;
					camlockpos.y = campoint.y + camMovement;
				case 2:
					camlockpos.x = campoint.x;
					camlockpos.y = campoint.y - camMovement;
				case 3:
					camlockpos.x = campoint.x + camMovement;
					camlockpos.y = campoint.y;
			}
			speed = velocity;
			timer = 1;
			camlock = true;
		}
	}
}