
var bg:FlxSprite;
var floatingheads = true;

function create(){
    bg = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/17bucks/BG'));
    bg.antialiasing = true;
    bg.scrollFactor.set(0.9, 0.9);
    bg.setGraphicSize(Std.int(bg.width * 2.9));
    bg.active = false;
    insert(members.indexOf(dad), bg);
    add(bg);

    sloth = new FlxSprite(375, 450);
    sloth.frames = Paths.getSparrowAtlas('stages/fitin/metal');
    sloth.animation.addByPrefix('stare', 'metalsos', 24, true);
    sloth.animation.play('stare');
    sloth.antialiasing = true;
    sloth.scrollFactor.set(0.9, 0.9);
    sloth.active = true;
    insert(members.indexOf(dad), sloth);
    add(sloth);

    wrath = new FlxSprite(160, 240);
    wrath.frames = Paths.getSparrowAtlas('stages/fitin/rage');
    wrath.animation.addByPrefix('stare', 'angrysos', 24, true);
    wrath.animation.play('stare');
    wrath.antialiasing = true;
    wrath.scrollFactor.set(0.92, 0.92);
    wrath.active = true;
    insert(members.indexOf(dad), wrath);
    add(wrath);

    greed = new FlxSprite(-50, 575);
    greed.frames = Paths.getSparrowAtlas('stages/fitin/grinch');
    greed.animation.addByPrefix('stare', 'grinchsos', 24, true);
    greed.animation.play('stare');
    greed.antialiasing = true;
    greed.setGraphicSize(Std.int(greed.width * 1.2));
    greed.scrollFactor.set(1.2, 1.2);
    greed.active = true;
    add(greed);
}

function postUpdate(elapsed){
    curDecBeat = (Conductor.songPosition/5000)*(Conductor.bpm/60);
    if (floatingheads){
    sloth.y += 1.2 * Math.sin(curDecBeat / 1.2 * Math.PI) * elapsed * 60;
    wrath.y += 1.2 * Math.sin(curDecBeat / 1.2 * Math.PI) * elapsed * 60;
    greed.y += 1.2 * Math.sin(curDecBeat / 1.2 * Math.PI) * elapsed * 60;
}
}