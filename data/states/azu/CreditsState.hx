
import flixel.FlxObject;
import flixel.addons.display.FlxBackdrop;
import funkin.menus.MainMenuState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

var creditsThing:Array<Dynamic> = [
    [
        "fellyn yukira", "fellyn", ["Porter", "Coder"], false,
        "hiiii it's me fellyn :D"
    ],
    [
        "frijolero", "frijolero", ["Director", "Artist"], true,
        "yo viendo tu pesoplumeada"
    ],
    [
        "stereo", "stereo", ["Director", "Writer"], false,
        "this mod has been going through a lot of stuff and we're glad that at least we managed to get the demo doneand not canceled. behold the probably greatest azumanga daioh fnf mod ever. go watch the anime and the manga if you havent, it's peak. frijolero quiere tener una vida y familia con chihiro de azumanga daioh copia y pega esta verda"],
    [
        "neon t. flame", "neon", ["Coder"], false,
        "leiam yotsuba"
    ],
    [
        "jeng", "jeng", ["Artist"], true,
        "look at her"
    ],
    [
        "freaky kaorin", "freakykaorin", ["Coder", "Charter", "Animator", "Chromatic Maker"], true,
        "Hi azugang! Freak off the mic."
    ],
    [
        "skwoop", "skwoop", ["Composer"], false,
        "The light glimmers, my feeling must not hide\nExistence is Enough when we coincide\nI hope to convey my heart's calling in the coming, but For neow ibahve nothing and what is coming fuckein sucks"
    ],
    [
        "keekhouse", "keekhouse", ["Composer"], true,
        "Eash goofy ass song I made for this mod is dedicated to Azumanga and its awesome fanbase, as well as all the people I've been able to become friends with over the course of this mods development. Chiyo vs Pterodactyl coming in V1."
    ],
    [
        "dumbalice", "dumb", ["Charter"], true,
        "I charted a lot of cool songs by these awesome composers. It was really fun.\nbtw I am this silly cat.\n\nME LA PELAS ARBU"
    ],
    [
        "snew", "snew", ["Artist", "Animator"], true,
        "Un saludo a todos los mafufos"
    ],
    [
        "flashman2007", "flash", ["Composer"], true,
        "hola, mi nombre es flash. soy un calco de bullet de paradise pd que hace musica en fl studio 21, thx a azufunkin por dejarme entrar al mod. (P.D: me gusta nichijou)"
    ],
    [
        "elbendy1", "bendy", ["Composer"], true,
        "909 snare.wav my beloved"
    ],
    [
        "truecore", "truecore", ["Composer"], false,
        "Hey there! I'm not a composer for this version since the remake for Kagura's song has unfortunately been pushed to V1 due to unforeseen circumstances. But don't worry! I've got some stuff planned for this mod, and i'm sure all of you are going to enjoy it.\nAlso, be sure to look forward to Azufunkin Gaiden!"
    ],
    [
        "seansecret", "sean", ["Composer"], true,
        "Sata Andagi"
    ],
    [
        "urikunuwu", "urikun", ["Artist"], true,
        "Se carreo el fondo de este mod todo mal hecho, imagina dibujar bien, SIGANME ARROBA URIKUNNT RAPIDO RAPIDO RAPIDO (los quiero mucho)"
    ],
    [
        "yaiz", "yaiz", ["Artist"], true,
        "chupenme las nalgas"
    ],
    [
        "bruhleoo", "leo", ["Charter"], true,
        "un saludo a los funkipapus"
    ],
    [
        "woyer", "woyer", ["Charter"], true,
        "TablosAF would be really proud of this team and all the devs, this is very accurate mod, all the devs are amazing!!\nexept Bendy, he doesn't know about my peso plumeadas, by the way, enjoy it and hiii\ncommunity games, it's me the guy from missa :D"
    ],
    [
        "organic", "organic", ["Artist"], true,
        "ola yo ise espraits como estan"
    ],
    [
        "mr. crimson", "crimson", ["Composer"], false,
        "por favor denme chamba ocupo trabajar en más mods (jueguen gotr v1 ya estamos trabajando en la v2)"
    ],
];

var iconsGroup:FlxTypedGroup<FlxSprite> = [];

var curSelected:Int = 0;
var camFollow:FlxObject;

var arrowThing:FlxSprite;

var nameTxt:FlxText;
var jobsTxt:FlxText;
var descTxt:FlxText;
var imgCred:FlxSprite;

function create() {
    if (FlxG.sound.music.name != 'CreditTheme') {
        CoolUtil.playMusic(Paths.music('creditTheme'), true);
        FlxG.sound.music.name = 'CreditTheme';
    }

    var bg:FlxBackdrop = new FlxBackdrop().loadGraphic(Paths.image('menus/bgmenu'));
    bg.velocity.x = 50;
    bg.velocity.y = 50;
    bg.antialiasing = Options.antialiasing;
    bg.scrollFactor.set();
	add(bg);

    var blackThing = new FlxSprite(360, 38).loadGraphic(Paths.image('credits/black'));
    blackThing.antialiasing = Options.antialiasing;
    blackThing.scrollFactor.set();
    add(blackThing);

    arrowThing = new FlxSprite(50, 280).loadGraphic(Paths.image('credits/thing'));
    arrowThing.antialiasing = Options.antialiasing;
    arrowThing.scrollFactor.set();
    add(arrowThing);

    camFollow = new FlxObject(0, 0, 1, 1);
	add(camFollow);

    for (i => peps in creditsThing) {
        var tex = Paths.image('credits/none');
        if (Assets.exists(Paths.image('credits/' + peps[1]))) tex = Paths.image('credits/' + peps[1]);

        var icon = new FlxSprite(140, (i * 150) + 250).loadGraphic(tex);
        icon.antialiasing = Options.antialiasing;
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

    descTxt = new FlxText(blackThing.x + 10, blackThing.y + 300, blackThing.width - 400, '');
    descTxt.setFormat(Paths.font("vcr.ttf"), 28, FlxColor.WHITE, "left");
    descTxt.scrollFactor.set();
    add(descTxt);

    imgCred = new FlxSprite();
    imgCred.antialiasing = Options.antialiasing;
    imgCred.scrollFactor.set();
    imgCred.screenCenter();
    add(imgCred);

    changeItem(0);
}

var timeArrow:Float = 0;
function update(elapsed:Float) {
    if (controls.BACK) {
        FlxG.switchState(new MainMenuState());
        if (FlxG.sound.music.name == 'CreditTheme') FlxG.sound.music.persist = false;
    }

    if (controls.UP_P)
        changeItem(-1);

    if (controls.DOWN_P)
        changeItem(1);

    timeArrow += elapsed * 2;
    if (arrowThing != null)
        arrowThing.x = 70 + (10 * Math.sin(timeArrow));
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
    descTxt.text = creditsThing[curSelected][4];

    if (creditsThing[curSelected][3])
        imgCred.loadGraphic(Paths.image('credits/images/' + creditsThing[curSelected][1]));

    imgCred.screenCenter();
    imgCred.visible = creditsThing[curSelected][3];
    imgCred.x += 430;
    imgCred.y += 150;
}