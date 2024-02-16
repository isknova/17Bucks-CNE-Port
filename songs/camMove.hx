import flixel.FlxCamera;
import flixel.FlxCameraFollowStyle;

//change this ones//
var camMovement:Int = 20;
var velocity:Int = 0.12;

//leave this ones alone//
var campoint:FlxPoint;
var camlockpos:FlxPoint;
var camlock:Bool = false;
var camon:Bool = true;
var speed:Float = 0.04;
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
				speed = 0.04;

			case 1:
				campoint = FlxPoint.get(camFollow.x, camFollow.y);
				camlock = false;
				speed = 0.04;
		}
		curTarget = curCameraTarget;
	}

	if (timer >= 0) {
		timer -= elapsed;
	} else {
		if (camon) {
			speed = 0.04;
			camFollow.setPosition(campoint.x, campoint.y);
			camlock = false;
			FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, speed);
		}
	}

	if (camlock && camon)
		camFollow.setPosition(camlockpos.x, camlockpos.y);
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
			FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, speed);
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
			FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, speed);
		}
	}
}