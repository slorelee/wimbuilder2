var Project = {
    root_path: "Projects",
    New:function(name, preset, lazy) {
        var project = {};
        project.name = name;
        project.path = Project.root_path + '/' + name;
        project.uri = project.path;
        project.wb_root = $wb_root.replace(/\\/g, '/');
        project.full_path = project.wb_root + '/' + project.path;
        project.full_uri = project.full_path;
        project.full_path = project.full_path.replace(/\//g, '\\');
        function load_file(file) {
            return load_text_file(project.path + '/' + file);
        };
        project.load_desc = function() {
            return load_file('_Assets_/desc.json');
        };
        project.load_html = function() {
            return load_file('_Assets_/intro.html');
        };
        project.desc = project.load_desc();
        project.html = project.load_html();
        var $patches_opt = {};
        var $patches_preset = 'default';
        eval(load_file('_Assets_/config.js'));
        if (preset) {
            $patches_preset = preset;
        }
        project.presets = get_files(project.path + '/_Assets_/preset');
        project.preset = '-';
        if ($patches_preset != '') {
            eval(load_file('_Assets_/preset/' + $patches_preset + '.js'));
            project.preset = $patches_preset;
        }
        if (typeof(patches_state_init) == 'function') {
            project.patches_state_init = patches_state_init;
        }
        project.patches_opt = $patches_opt;
        if (!lazy) {
            project.patches_tree_data = Project.GetPatches(project.path);
        }
        return project;
    },
    GetPatches:function(rootdir) {
        function get_sub_patches(rootdir, pdir, pid, arr) {
            var cdir = rootdir + '/' + pdir;
            if (pid == '#') cdir = pdir;

            var folder = fso.GetFolder(cdir);
            var fenum = new Enumerator(folder.SubFolders);
            for (var i = 0 ; !fenum.atEnd();i++) {
                var name = fenum.item().Name;
                var cid = pdir + '/' + name;
                if (pid == '#') cid = name;
                if (fso.FileExists(cdir + '/' + name + '/main.html')) {
                    var state_opened = false;
                    var state_selected = true;
                    var def_conf = load_utf8_file(cdir + '/' + name + '/en-US.js');
                    var i18n = load_utf8_file(cdir + '/' + name + '/' + $lang + '.js');

                    // fallback
                    if (i18n == '') {
                        i18n = def_conf;
                    } else {
                        i18n = def_conf + '\r\n' + i18n;
                    }
                    if (i18n != '') {
                        var patch_name = null;
                        var patch_opened = null;
                        var patch_selected = null;
                        eval(i18n);
                        if (patch_name != null) name = patch_name;
                        if (patch_opened != null) state_opened = patch_opened;
                        if (patch_selected != null) state_selected = patch_selected;
                    } else {
                        var pos = name.indexOf('-');
                        if (pos >= 0) name = name.substring(pos + 1);
                    }

                    var item = { "id" : cid , "parent" : pid, "text" : name,
                     "state": {opened: state_opened, checked: state_selected} };
                     if (cid == '_CustomFiles_') {
                        arr.unshift(item)
                    } else {
                        arr.push(item);
                    }
                    get_sub_patches(rootdir, cid, cid, arr);
                }
                fenum.moveNext();
            }
        };
        var arr = new Array();
        get_sub_patches(rootdir, rootdir, '#', arr);
        return arr;
    }
}

function pj_button(name) {
    return '<button ' + ' id="pj_' + name + '"' +
        ' class="pure-button pure-button-primary project-button">' +
        name + '</button><br/>';
}