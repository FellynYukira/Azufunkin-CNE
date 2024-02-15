import haxe.io.Path;
import haxe.Json;


var fpsPlusEvents = [];

function create() {
    var eventPath = Paths.file('songs/' + curSong + '/events.json');
    var theEvents = [];

    if (Assets.exists(eventPath)) {
        theEvents = Json.parse(Assets.getText(eventPath));
        for (event in theEvents.events.events) {
            var splitVal = event[3].split(';');

            var ev = {
                params: [],
                time: 0,
                name: ""
            }

            ev.name = splitVal[0];
            ev.time = event[1];
            for (i => val in splitVal) {
                if (i == 0) continue;
                ev.params.push(val);
            }

            fpsPlusEvents.push(ev);
        }
    }
}

function update() {
    for (event in fpsPlusEvents) {
		if(event.time <= Conductor.songPosition) {
            executeFpsPlusEvent(event);

            var index = fpsPlusEvents.indexOf(event);
            fpsPlusEvents.splice(index, 1);
        }
    }
}

function executeFpsPlusEvent(event) {
    switch(event.name) {
        case 'camBop':
            FlxG.camera.zoom += 0.015;
            camHUD.zoom += 0.03;

        case 'camBopBig':
            FlxG.camera.zoom += 0.025;
            camHUD.zoom += 0.04;
        
        case 'flash':
            FlxG.camera.flash(FlxColor.WHITE, Std.parseFloat(event.params[0]));

        case 'flashHud':
            camHUD.flash(FlxColor.WHITE, Std.parseFloat(event.params[0]));

        case 'fadeOut':
            FlxG.camera.fade(FlxColor.BLACK, Std.parseFloat(event.params[0]));

        case 'fadeOutHud':
            camHUD.fade(FlxColor.BLACK, Std.parseFloat(event.params[0]));

        case 'gamealpha':
            FlxG.camera.alpha = Std.parseFloat(event.params[0]);
        
        case 'camZoom':
            var zoomChange:Float = Std.parseFloat(event.params[0]);
            var duration:Float = Std.parseFloat(event.params[1]);
            var tweenEase:FlxEase = switch(event.params[2]) {
                case "Linear": FlxEase.linear;
                default: Reflect.field(FlxEase, event.params[2]);
            };
            FlxTween.tween(FlxG.camera, {zoom: zoomChange}, duration, {ease: tweenEase, onComplete: function() {
                defaultCamZoom = zoomChange;
            }});
        
        case 'disappear':
            for (strum in strumLines)
                for (char in strum.characters)
                    if (event.params[0] == char.curCharacter)
                        char.visible = false;
        
        case 'appear':
            for (strum in strumLines)
                for (char in strum.characters)
                    if (event.params[0] == char.curCharacter)
                        char.visible = true;

        case 'playAnim':
            switch(event.params[0].toLowerCase()) {
                case 'dad': dad.playAnim(event.params[1]);
                case 'gf': gf.playAnim(event.params[1]);
                default: boyfriend.playAnim(event.params[1]);
            }
        
        case 'angle':
            FlxG.camera.angle = Std.parseFloat(event.params[0]);
            FlxTween.tween(FlxG.camera, {angle: 0}, 0.4, {ease: FlxEase.circOut});
    }
}