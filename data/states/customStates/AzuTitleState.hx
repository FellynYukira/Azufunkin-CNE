
import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
import funkin.backend.MusicBeatState;
import funkin.menus.MainMenuState;

var introVideo:FlxVideo;

var skipped:Bool = false;
var pressedEnter:Bool = false;

var flashSpr:FlxSprite;
var logoBump:FlxSprite;
var enterSpr:FlxSprite;

var leftBorder:FlxSprite;
var rightBorder:FlxSprite;

function create() {
    MusicBeatState.skipTransIn = true;

    if (!TitleState.initialized) {
        introVideo = new FlxVideo();
        introVideo.onEndReached.add(skipIntro);
        var path = Paths.file("videos/azufunkinIntro.mp4");
        introVideo.load(Assets.getPath(path));

        new FlxTimer().start(1, introVideo.play());
        startIntro();

        TitleState.initialized = true;
    } else new FlxTimer().start(1, startIntro());
}

function update(elapsed:Float) {
    if (skipped && !pressedEnter && FlxG.keys.justPressed.ENTER) {
        FlxG.sound.play(Paths.sound('menu/confirm'));
        enterSpr.animation.play('press');

        pressedEnter = true;

        FlxTween.tween(leftBorder, {x: -leftBorder.width}, 1.5, {ease: FlxEase.sineIn});
        FlxTween.tween(rightBorder, {x: FlxG.width}, 1.5, {ease: FlxEase.sineIn});
        new FlxTimer().start(2, function() {
            FlxG.switchState(new MainMenuState());
        });
    }
}

function startIntro() {
    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/title/bgtitle'));
    bg.antialiasing = true;
    bg.screenCenter();
    add(bg);

    logoBump = new FlxSprite(372, 30);
    logoBump.frames = Paths.getFrames('menus/logoBumpin');
    logoBump.animation.addByPrefix('bump', 'logo bumpin', 24, false);
    logoBump.animation.play('bump', true);
    logoBump.antialiasing = true;
    add(logoBump);

    enterSpr = new FlxSprite(115, FlxG.height * 0.8);
    enterSpr.frames = Paths.getFrames('menus/titlescreen/titleEnter');
    enterSpr.scale.set(0.7, 0.7);
	enterSpr.animation.addByPrefix('idle', "Press Enter to Begin", 24);
	enterSpr.animation.addByPrefix('press', "ENTER PRESSED", 24);
	enterSpr.antialiasing = true;
	enterSpr.animation.play('idle');
	add(enterSpr);

    flashSpr = new FlxSprite().loadGraphic(Paths.image('menus/title/flash'));
    flashSpr.alpha = 0;
    add(flashSpr);

    leftBorder = new FlxSprite().loadGraphic(Paths.image('menus/title/border'));
    add(leftBorder);

    rightBorder = new FlxSprite().loadGraphic(Paths.image('menus/title/border'));
    rightBorder.x = FlxG.width - rightBorder.width;
    add(rightBorder);

    if (TitleState.initialized)
        skipIntro();
}

function skipIntro() {
    if (!skipped) {
        if (FlxG.game.contains(introVideo))
            FlxG.game.removeChild(introVideo);
    
        CoolUtil.playMenuSong();
    
        flashSpr.alpha = 1;
        FlxTween.tween(flashSpr, {alpha: 0}, 2);

        skipped = true;
    }
}

function beatHit() {
    if (logoBump != null)
        logoBump.animation.play('bump', true);
}