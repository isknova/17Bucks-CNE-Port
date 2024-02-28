
var bg:FlxSprite;

function create(){
    bg = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/17bucks/BG'));
    bg.antialiasing = true;
    bg.scrollFactor.set(0.9, 0.9);
    bg.setGraphicSize(Std.int(bg.width * 2.9));
    bg.active = false;
    insert(members.indexOf(dad), bg);
    add(bg);
}