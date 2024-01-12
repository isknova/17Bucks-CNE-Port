var psychIconArray = [];

function postCreate() {
    for (i in 0...iconArray.length) iconArray[i].visible = false;
    for (i in 0...songs.length) {
		var icon = makePsychIcon(songs[i].icon);
		psychIconArray.push(icon);
		add(icon);
	}
}

function postUpdate() {
    for (i in 0...psychIconArray.length) {
        psychIconArray[i].setPosition(iconArray[i].x, iconArray[i].y);
        psychIconArray[i].alpha = iconArray[i].alpha;
    }
}

function makePsychIcon(char:String) {
    var path = Paths.image('icons/' + char);

    var icon = new FlxSprite();
    icon.loadGraphic(path);
    icon.loadGraphic(path, true, Math.floor(icon.width / 2), Math.floor(icon.height));
    icon.updateHitbox();

    icon.animation.add(char, [0, 1], 0, false);
    icon.animation.play(char);

    icon.antialiasing = true;

    return icon;
}