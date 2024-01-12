
function onNoteHit(_) {
    if (_.noteType == 'GF Sing') {
        _.cancelAnim();
        gf.playSingAnim(_.direction, _.animSuffix, 'SING', _.forceAnim);
    }
}