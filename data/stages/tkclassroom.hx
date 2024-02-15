var tomo;
var kag;

function create() {
    importScript('data/scripts/camMove');
    tomo = strumLines.members[3].characters[0];
    kag = strumLines.members[4].characters[0];
}

function beatHit(curBeat) {
    if (curBeat == 276) {
        tomo.x -= 30;
        tomo.alpha = 0;
        FlxTween.tween(tomo, {x: tomo.x + 30, alpha: 1}, 0.7, {ease: FlxEase.sineOut});
    }
    if (curBeat == 410 || curBeat == 740) {
        for (spr in [bg, chichi, desks, bg1, bg2, bg3])
            FlxTween.color(spr, 1, FlxColor.WHITE, 0xFF646464);
    }
    if (curBeat == 472 || curBeat == 772) {
        for (spr in [bg, chichi, desks, bg1, bg2, bg3])
            FlxTween.color(spr, 1, 0xFF646464, FlxColor.WHITE);
    }
    if (curBeat == 805) {
        for (spr in [bg, chichi, desks, bg1, bg2, bg3, gf])
            spr.visible = false;
    
        FlxG.camera.bgColor = FlxColor.WHITE;

        for (spr in [dad, boyfriend, tomo, kag])
            spr.color = FlxColor.BLACK;
    }
    if (curBeat == 836) {
        for (spr in [bg, chichi, desks, bg1, bg2, bg3, gf])
            spr.visible = true;
    
        for (spr in [bg, chichi, desks, bg1, bg2, bg3])
            spr.color = 0xFF646464;
    
        FlxG.camera.bgColor = FlxColor.BLACK;

        for (spr in [dad, boyfriend, tomo, kag])
            spr.color = FlxColor.WHITE;
    }
}