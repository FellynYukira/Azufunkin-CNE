
function onNoteHit(event) {
    if (event.noteType == 'kagLaugh') {
        event.cancelAnim();
        event.character.playAnim('laugh');
    }
}