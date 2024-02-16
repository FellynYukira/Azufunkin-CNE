
import flixel.FlxObject;
import flixel.addons.display.FlxBackdrop;
import funkin.menus.MainMenuState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;

var creditsThing:Array<Dynamic> = [
    ["fellyn yukira", "fellyn", ["Porter", "Coder"], false, ""],
    ["frijolero", "frijolero", ["Director", "Artist"], true, "yo viendo tu pesoplumeada"],
    ["stereo", "stereo", ["Director", "Writer"], false, "this mod has been going through a lot of stuff and we're glad that at least we managed to get the demo doneand not canceled. behold the probably greatest azumanga daioh fnf mod ever. go watch the anime and the manga if you havent, it's peak. frijolero quiere tener una vida y familia con chihiro de azumanga daioh copia y pega esta verda"],
    ["neon t. flame", "neon", ["Coder"], false, "leiam yotsuba"],
    ["jeng", "jeng", ["Artist"], true, "look at her"],
    ["freaky kaorin", "freakykaorin", ["Coder", "Charter", "Animator", "Chromatic Maker"], true, "Hi azugang! Freak off the mic."],
    ["skwoop", "none", ["Composer"], false, "The light glimmers, my feeling must not hide\nExistence is Enough when we coincide\nI hope to convey my heart's calling in the coming, but For neow ibahve nothing and what is coming fuckein sucks"],
    ["keekhouse", "keekhouse", ["Composer"], true, ""],
    ["dumbalice", "dumb", ["Charter"], true, ""],
    ["snew", "snew", ["Artist", "Animator"], true, ""],
    ["flashman2007", "flash", ["Composer"], true, ""],
    ["elbendy1", "bendy", ["Composer"], true, ""],
    ["truecore", "none", ["Composer"], false, ""],
    ["seansecret", "none", ["Composer"], true, ""],
    ["urikunuwu", "urikun", ["Artist"], true, ""],
    ["yaiz", "yaiz", ["Artist"], true, ""],
    ["bruhleoo", "leo", ["Charter"], true, ""],
    ["woyer", "woyer", ["Charter"], true, ""],
    ["organic", "organic", ["Artist"], true, ""],
    ["mr. crimson", "crimson", ["Composer"], false, ""],
];

var iconsGroup:FlxTypedGroup<FlxSprite> = [];

var curSelected:Int = 0;

var camFollow:FlxObject;

var nameTxt:FlxText;
var jobsTxt:FlxText;

function create() {
    CoolUtil.playMusic(Paths.music('creditTheme'), false);

    var bg:FlxBackdrop = new FlxBackdrop().loadGraphic(Paths.image('menus/bgmenu'));
    bg.velocity.x = 50;
    bg.velocity.y = 50;
    bg.antialiasing = true;
    bg.scrollFactor.set();
	add(bg);

    var blackThing = new FlxSprite(360, 38).loadGraphic(Paths.image('credits/black'));
    blackThing.antialiasing = true;
    blackThing.scrollFactor.set();
    add(blackThing);

    var arrowThing = new FlxSprite(50, 280).loadGraphic(Paths.image('credits/thing'));
    arrowThing.antialiasing = true;
    arrowThing.scrollFactor.set();
    add(arrowThing);

    camFollow = new FlxObject(0, 0, 1, 1);
	add(camFollow);

    for (i => peps in creditsThing) {
        var tex = Paths.image('credits/none');
        if (Assets.exists(Paths.image('credits/' + peps[1]))) tex = Paths.image('credits/' + peps[1]);

        var icon = new FlxSprite(140, (i * 150) + 250).loadGraphic(tex);
        icon.antialiasing = true;
        icon.updateHitbox();
        icon.scrollFactor.set(0, 1);
        iconsGroup.push(icon);
        add(icon);
    }

    camFollow.setPosition(iconsGroup[curSelected].getMidpoint().x, iconsGroup[curSelected].getMidpoint().y + 40);
    FlxG.camera.follow(camFollow, null, 0.2);
	FlxG.camera.snapToTarget();

    nameTxt = new FlxText(blackThing.x, blackThing.y + 20, blackThing.width, creditsThing[curSelected][0].toUpperCase());
    nameTxt.setFormat(Paths.font("vcr.ttf"), 50, FlxColor.WHITE, "center");
    nameTxt.scrollFactor.set();
    add(nameTxt);

    jobsTxt = new FlxText(blackThing.x, blackThing.y + 110, blackThing.width, '');
    jobsTxt.setFormat(Paths.font("vcr.ttf"), 50, FlxColor.WHITE, "center");
    jobsTxt.scrollFactor.set();
    add(jobsTxt);

    changeItem(0);
}

function update(elapsed:Float) {
    if (controls.BACK)
        FlxG.switchState(new MainMenuState());

    if (controls.UP_P)
        changeItem(-1);

    if (controls.DOWN_P)
        changeItem(1);
}

function changeItem(add:Int) {
    curSelected += add;
    FlxG.sound.play(Paths.sound('menu/scroll'));

    if (curSelected > creditsThing.length-1)
        curSelected = 0;
    else if (curSelected < 0)
        curSelected = creditsThing.length-1;

    camFollow.setPosition(iconsGroup[curSelected].getMidpoint().x, iconsGroup[curSelected].getMidpoint().y + 40);

    nameTxt.text = creditsThing[curSelected][0].toUpperCase();
    
    var jobs = "";
    for (job in creditsThing[curSelected][2])
        jobs += "-" + job + "\n";

    jobsTxt.text = jobs;
}