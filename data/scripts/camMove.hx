import flixel.FlxCamera;
import flixel.FlxCameraFollowStyle;

var cammove = 10;

function postCreate() {
    FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, 0.06);
}

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
}