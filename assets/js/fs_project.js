var Project = {
    root_path: "Projects",
    New:function(name) {
        var project = {};
        project.name = name;
        project.path = Project.root_path + '/' + name;
        project.wb_root = $wb_root.replace(/\\/g, '/');
        project.full_path = project.wb_root + '/' + project.path;
        function load_file(file) {
            return load_text_file(project.path + '/' + file);
        };
        project.load_desc = function() {
            return load_file('desc.json');
        };
        project.load_html = function() {
            return load_file('main.html');
        };
        project.desc = project.load_desc();
        project.html = project.load_html();
        var $patches_opt = {};
        eval(load_file('config.js'));
        if (typeof(patches_state_init) == 'function') {
            project.patches_state_init = patches_state_init;
        }
        project.patches_opt = $patches_opt;
        project.patches_tree_data = Project.GetPatches(project.path);;
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
                if (!fso.FileExists(cdir + '/' + name + '/main.html')) return '';

                var i18n = load_utf8_file(cdir + '/' + name + '/' + $lang + '.js');
                var state_opened = false;
                var state_selected = true;
                if (i18n != '') {
                    eval(i18n);
                    if (typeof(patch_name) != "undefined") name = patch_name;
                    if (typeof(patch_opened) != "undefined") state_opened = patch_opened;
                    if (typeof(patch_selected) != "undefined") state_selected = patch_selected;
                } else {
                    var pos = name.indexOf('-');
                    if (pos >= 0) name = name.substring(pos + 1);
                }

                var item = { "id" : cid , "parent" : pid, "text" : name,
                 "state": {opened: state_opened, checked: state_selected} };
                arr.push(item);
                get_sub_patches(rootdir, cid, cid, arr);
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