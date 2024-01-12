import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.math.FlxPoint;

public var colouredBar = (dad != null && dad.xml != null && dad.xml.exists("color")) ? CoolUtil.getColorFromDynamic(dad.xml.get("color")) : 0xFFFFFFFF;
public var sicks:Int = 0;
public var goods:Int = 0;
public var bads:Int = 0;
public var shits:Int = 0;
public var timeBarBG:FlxSprite;
public var timeBar:FlxBar;
public var timeTxt:FlxText; // I forgot why I made these public variables.......
public var hudTxt:FlxText;
public var hudTxtTween:FlxTween;
public var ratingFC:String = "FC";
public var botplayTxt:FlxText;
public var botplaySine:Float = 0;
public var ratingStuff:Array<Dynamic> = [
    ['You Suck!', 0.2],
    ['Shit', 0.4],
    ['Bad', 0.5],
    ['Bruh', 0.6],
    ['Meh', 0.69],
    ['Nice', 0.7],
    ['Good', 0.8],
    ['Great', 0.9],
    ['Sick!', 1],
    ['Perfect!!', 1]
];

if (enablePauseMenu) {
    PauseSubState.script = 'data/scripts/funnypause';
}
function onPostNoteCreation(event) {
    if (FlxG.save.data.Splashes) {
    	var note = event.note;
	    note.splash = "diamond";
    }
    else if (FlxG.save.data.Splashes == 0) {
        var note = event.note;
        note.splash = "vanilla";
    }
}

function getRating(accuracy:Float):String {
    if (accuracy < 0) {
        return "?";
    }
    for (rating in ratingStuff) {
        if (accuracy < rating[1]) {
            return rating[0];
        }
    }
    return ratingStuff[ratingStuff.length - 1][0];
}

function create() {
    timeTxt = new FlxText(0, 19, 400, "X:XX", 32);
    timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.antialiasing = true;
    timeTxt.scrollFactor.set();
    timeTxt.alpha = 0;
    timeTxt.borderColor = 0xFF000000;
    timeTxt.borderSize = 2;
    timeTxt.screenCenter(FlxAxes.X);

    hudTxt = new FlxText(0, 685, FlxG.width, "Score: 0 | Misses: 0 | Rating: ?");
    hudTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    hudTxt.borderSize = 1.25;
    hudTxt.antialiasing = true;
    hudTxt.scrollFactor.set();
    hudTxt.screenCenter(FlxAxes.X);

    botplayTxt = new FlxText(400, 83, FlxG.width - 800, "BOTPLAY", 32);
    botplayTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    botplayTxt.scrollFactor.set();
    botplayTxt.borderSize = 1.25;
    botplayTxt.alpha = 0;
    botplayTxt.cameras = [camHUD];
    add(botplayTxt);

    timeBarBG = new FlxSprite();
    timeBarBG.x = timeTxt.x;
    timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
    timeBarBG.alpha = 0;
    timeBarBG.scrollFactor.set();
    timeBarBG.color = FlxColor.BLACK;
    timeBarBG.loadGraphic(Paths.image("psychTimeBar"));

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
    timeBar.scrollFactor.set();
    timeBar.createFilledBar(0xFF000000,0xFFFFFFFF);
    if (FlxG.save.data.colouredBar) {
        timeBar.createFilledBar(0xFF000000, colouredBar);
    }
    timeBar.numDivisions = 400;
    timeBar.alpha = 0;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.unbounded = true;
    add(timeBarBG);
    add(timeBar);
    add(timeTxt);

    timeBarBG.x = timeBar.x - 4;
    timeBarBG.y = timeBar.y - 4;

    hudTxt.cameras = [camHUD];
    timeBar.cameras = [camHUD];
    timeBarBG.cameras = [camHUD];
    timeTxt.cameras = [camHUD];
}

function onSongStart() {
    if (timeBar != null) {
        FlxTween.tween(timeBar, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    }
    if (timeBarBG != null) {
        FlxTween.tween(timeBarBG, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    }
    if (timeTxt != null) {
    FlxTween.tween(timeTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    }
    if (botplayTxt != null && FlxG.save.data.botplayOption) {
        FlxTween.tween(botplayTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    }
}

function update(elapsed:Float) {
    if (inst != null && timeBar != null && timeBar.max != inst.length) {
        timeBar.setRange(0, Math.max(1, inst.length));
    }
    if (inst != null && timeTxt != null) {
        var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
        var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
        var minutes = Std.int(timeRemaining / 60);
        timeTxt.text = minutes + ":" + seconds;
    }
    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    if (songScore > 0 || acc > 0 || misses > 0) {
        hudTxt.text = "Score: " + songScore + " | Misses: " + misses +  " | Rating: " + rating + " (" + acc + "%)" + " - " + ratingFC;
    }
    if (FlxG.save.data.botplayOption) {
        botplaySine += 180 *  FlxG.elapsed;
        botplayTxt.alpha = 1 - Math.sin((Math.PI * botplaySine) / 180);
        player.cpu = true;
    } 
}

function onPlayerHit(note:Note) {
    if(!note.isSustainNote){
        if(hudTxtTween != null) {
            hudTxtTween.cancel();
        }
        hudTxt.scale.x = 1.075;
        hudTxt.scale.y = 1.075;
        hudTxtTween = FlxTween.tween(hudTxt.scale, {x: 1, y: 1}, 0.2, {
            onComplete: function(twn:FlxTween) {
                hudTxtTween = null;
            }
        });
    
    }
    if (!note.isSustainNote) {
        for (i in 0...note.rating.length) {
            var rating:String = note.rating.substr(i, 4);
            if (rating == "sick") {
                sicks += 1;
            } else if (rating == "good") {
                goods += 1;
            } else if (rating == "bad") {
                bads += 1;
            } else if (rating == "shit") {
                shits += 1;
            }
       }
    }
    if (misses == 0) {
        if (sicks > 0) ratingFC = "SFC";
        if (goods > 0 && accuracy < 1) ratingFC = "GFC";
        if (bads > 0 || shits > 0) ratingFC = "FC";
    }
    if (misses > 0) {
        if (misses < 10) ratingFC = "SDCB";
        else if (misses >= 10) ratingFC = "Clear";
    }
}

function postCreate() {
    for (i in [missesTxt, accuracyTxt, scoreTxt]) {
        i.visible = false;
    }
    if (downscroll) {
        hudTxt.y = healthBarBG.y - 58;
    } 
    add(hudTxt);
    healthBar.y = FlxG.height * 0.89;
    healthBarBG.y = healthBar.y - 4;
    iconP1.y = healthBar.y - 75;
    iconP2.y = iconP1.y;
    if (!downscroll) {
        hudTxt.y = healthBarBG.y + 38;
    }
    if (FlxG.save.data.showBar) {
        for (i in [timeTxt, timeBar, timeBarBG]) {
            i.visible = false;
        }
    }
    if (FlxG.save.data.showTxt) {
        hudTxt.visible = false;
    }
}