var Patch = {
    New:function(project, name) {
        var patch = {};
        patch.project = project;
        patch.name = name;
        patch.path = project.path + '/' + name;
        function load_file(file) {
            if (!fso.FileExists(patch.path + '/' + file)) return '';
            var file = fso.OpenTextFile(patch.path + '/' + file, ForReading);
            var text = file.readall();
            file.close();
            return text;
        };
        patch.load_desc = function() {
            return load_file('desc.json');
        };
        patch.load_html = function() {
            return load_file('main.html');
        };
        patch.desc = patch.load_desc();
        patch.html = patch.load_html();
        return patch;
    }
}

function pj_button(name) {
    return '<button ' + ' id="pj_' + name + '"' +
        ' class="pure-button pure-button-primary project-button">' +
        name + '</button><br/>';
}