var splitMode:Bool = false;

function onCameraMove(event) {
    event.cancel();

    camFollow.x = 0;
    camFollow.y = 270;
}

function update() {
    if (!splitMode) {
        bgkaorin.visible = (curCameraTarget == 1);
        boyfriend.visible = (curCameraTarget == 1);
    } else boyfriend.visible = true;
}

function beatHit(curBeat) {
    if (curBeat == 240) {
        splitMode = true;
        boyfriend.y -= 720;
        FlxTween.tween(boyfriend, {y: 100}, 1.5, {ease: FlxEase.circOut});
        FlxTween.tween(dad, {x: dad.x + 130}, 1.5, {ease: FlxEase.circOut});
    }
}