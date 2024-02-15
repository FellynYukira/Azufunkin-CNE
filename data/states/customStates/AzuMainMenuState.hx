
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;
import funkin.menus.TitleState;
import funkin.menus.ModSwitchMenu;
import funkin.menus.FreeplayState;
import funkin.options.OptionsMenu;
import flixel.effects.FlxFlicker;
import funkin.editors.EditorPicker;
import funkin.backend.MusicBeatState;

var curSelected:Int = 0;
var optionMoment = ['freeplay', 'options', 'credits', 'discord'];

var menuItems:FlxSpriteGroup;
var artMenu:FlxSprite;

function create() {
    CoolUtil.playMenuSong();

    var bg:FlxBackdrop = new FlxBackdrop().loadGraphic(Paths.image('menus/bgmenu'));
    bg.velocity.x = 50;
    bg.velocity.y = 50;
    bg.antialiasing = true;
	add(bg);

    menuItems = new FlxSpriteGroup(-438, 40);
    add(menuItems);
    FlxTween.tween(menuItems, {x: 138}, 1, {ease: FlxEase.circOut, startDelay: 0.2});

    var sideMenu:FlxSprite = new FlxSprite(-250).loadGraphic(Paths.image('menus/azufunkinthemodificationtopmenu'));
    sideMenu.antialiasing = true;
    add(sideMenu);
    FlxTween.tween(sideMenu, {x: 0}, 1, {ease: FlxEase.circOut});

    for (i => option in optionMoment) {
        var xPos = (i % 2 == 1 ? 120 : 0);
        var menuItem = new FlxSprite(xPos, (i * 160)).loadGraphic(Paths.image('menus/' + option));
        menuItem.antialiasing = true;
        menuItem.ID = i;
        var scale = (i == curSelected ? 1.25 : 1);
        menuItem.scale.set(scale, scale);
        menuItems.add(menuItem);
    }

    artMenu = new FlxSprite(650, 130).loadGraphic(Paths.image('menus/char' + curSelected));
    artMenu.antialiasing = true;
    add(artMenu);

    changeItem(0);
}

var selectedSomethin:Bool = false;

function update(elapsed:Float) {
    if (FlxG.sound.music.volume < 0.8)
        FlxG.sound.music.volume += 0.5 * elapsed;

    if (!selectedSomethin)
	{
		if (FlxG.keys.justPressed.SEVEN) {
            persistentUpdate = false;
            persistentDraw = true;
            openSubState(new EditorPicker());
        }

		if (controls.UP_P)
			changeItem(-1);

		if (controls.DOWN_P)
			changeItem(1);

		if (controls.BACK)
			FlxG.switchState(new TitleState());

		if (controls.SWITCHMOD) {
			openSubState(new ModSwitchMenu());
			persistentUpdate = false;
			persistentDraw = true;
		}

		if (controls.ACCEPT)
            selectItem();
	}

    for (spr in menuItems.members) {
        var scale = FlxMath.lerp(spr.scale.x, (spr.ID == curSelected ? 1.2 : 1), 0.2);
        spr.scale.set(scale, scale);
    }
}

function selectItem() {
    var daChoice:String = optionMoment[curSelected];

    if (daChoice == 'discord') {
        CoolUtil.openURL("https://discord.com/invite/pEGSyWCaeH");
    } else {
        selectedSomethin = true;
        FlxG.sound.play(Paths.sound('menu/confirm'));

        FlxFlicker.flicker(menuItems.members[curSelected], 1, Options.flashingMenu ? 0.06 : 0.15, true, false, function(flick:FlxFlicker) {
            switch (daChoice) {
                case 'freeplay': FlxG.switchState(new FreeplayState());
                case 'options': FlxG.switchState(new OptionsMenu());
                case 'credits': FlxG.switchState(new MusicBeatState(true, 'customStates/AzuCreditsState'));
                default:
                    FlxG.sound.play(Paths.sound('menu/cancel'));
                    selectedSomethin = false;
            }
        });
    }
}

var artTween:FlxTween;
function changeItem(add:Int) {
    curSelected += add;
    FlxG.sound.play(Paths.sound('menu/scroll'));

    if (curSelected > optionMoment.length-1)
        curSelected = 0;
    else if (curSelected < 0)
        curSelected = optionMoment.length-1;

    artMenu.loadGraphic(Paths.image('menus/char' + curSelected));
    artMenu.updateHitbox();
    artMenu.x = FlxG.width + 20;
    if (artTween != null) artTween.cancel();
    artTween = FlxTween.tween(artMenu, {x: 650}, 0.8, {ease: FlxEase.sineOut, onComplete: function() {
        artTween = null;
    }});
}