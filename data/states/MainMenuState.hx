import lime.ui.FileDialog;
import lime.ui.FileDialogType;
import openfl.net.FileReference;
import sys.io.File;
//fire when pressed
function update() {
    if (FlxG.keys.justPressed.Q) {
      psychConverter();
    }
}
//converts psych jsons lol
function psychConverter() {
    var fDial = new FileDialog();    
    fDial.onSelect.add(function(file) {
        var fileName = file.split('\\');
        fileName = fileName[fileName.length - 1].split('.');
        fileName = fileName[fileName.length - 2];
        var json = CoolUtil.parseJsonString(File.getContent(file));
        var xmlNew = '<!DOCTYPE codename-engine-character> <!-- Made with WizardMantis\'s Character Converter -->\n<character x="'+json.position[0]+'" y="'+json.position[1]+'" icon="'+json.healthicon+'" flipX="'+json.flip_x+'" camx="'+json.camera_position[0]+'" camy="'+json.camera_position[1]+'" holdTime="'+json.sing_duration+'" scale="'+json.scale+'">\n';
        for (i in 0...json.animations.length) {
            xmlNew += '\t<anim name="'+json.animations[i].anim+'" anim="'+json.animations[i].name+'" fps="'+json.animations[i].fps+'" loop="'+json.animations[i].loop+'" x="'+(json.animations[i].offsets[0] / json.scale)+'" y="'+(json.animations[i].offsets[1] / json.scale)+'"';
            if (json.animations[i].indices.length > 0) xmlNew += ' indices="'+json.animations[i].indices+'"/>\n'; // note to self fix indices to not have brackets :(
            else xmlNew += '/>\n';
        }
        xmlNew += '</character>';
        new FileReference().save(xmlNew, fileName + '.xml');
    });
    fDial.browse(FileDialogType.OPEN, 'json', null, 'Open A Psych Engine Character JSON.');
}