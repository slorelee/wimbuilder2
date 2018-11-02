var Patch = {
    New:function(project, name) {
        var patch = {};
        patch.project = project;
        patch.name = name;
        patch.path = project.path + '/' + name;
        function load_file(file) {
            return load_text_file(patch.path + '/' + file);
        };
        patch.load_desc = function() {
            return load_file('desc.json');
        };
        patch.load_html = function() {
            return load_file('main.html');
        };
        patch.desc = patch.load_desc();
        patch.html = patch.load_html();
        var i18n = load_utf8_file(patch.path + '/' + $lang + '.js');
        if (i18n != '') {
            eval(i18n);
            if (typeof(patch_i18n) != "undefined") {
                for (key in patch_i18n) {
                    patch.html = patch.html.replace(key, patch_i18n[key]);
                }
            }
        }
        return patch;
    }
}

function pj_button(name) {
    return '<button ' + ' id="pj_' + name + '"' +
        ' class="pure-button pure-button-primary project-button">' +
        name + '</button><br/>';
}