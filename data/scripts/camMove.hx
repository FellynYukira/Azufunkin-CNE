var cammove = 10;
var speed = 1.5;

function postUpdate(elapsed:Float) {
    switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
        case "singLEFT" | "singLEFT-alt": 
            camFollow.x -= cammove;
        case "singDOWN" | "singDOWN-alt": 
            camFollow.y += cammove;
        case "singUP" | "singUP-alt": 
            camFollow.y -= cammove;
        case "singRIGHT" | "singRIGHT-alt": 
            camFollow.x += cammove;
    }
    FlxG.camera.followLerp = FlxMath.bound(elapsed * 2.4 * speed / (FlxG.updateFramerate / 60), 0, 1);
}