function create() {
	boyfriend.cameraOffset.x -= 100;
	boyfriend.cameraOffset.y -= 100;

	dad.cameraOffset.x += 100;
	dad.cameraOffset.y += 100;

	gf.visible = false;
}

function onNoteHit() {
	if (defaultCamZoom != 0.65)
		defaultCamZoom = 0.65;
}

function stepHit(curStep) {
	if (curStep == 1211) {
		gf.visible = true;
		gf.playAnim('drop');
	}
}

function beatHit(curBeat) {
	if (curBeat >= 80 && curBeat < 111)
		camZoomingInterval = 1;
	else
		camZoomingInterval = 4;
}