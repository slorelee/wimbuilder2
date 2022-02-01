var $patches_preset = null;

var Project = {
    root_path: "Projects",
    New:function(name, preset, lazy) {
        var project = {};
        project.name = name;
        project.path = Project.root_path + '/' + name;
        project.uri = '../' + project.path;
        project.app_root = $app_root.replace(/\\/g, '/');
        project.full_path = project.app_root + '/' + project.path;
        project.appdata_full_path = project.app_root + '/' + $appdata_dir + '/' + project.path;
        project.full_uri = project.full_path;
        project.full_path = project.full_path.replace(/\//g, '\\');
        project.style = '../' + project.path + '/_Assets_/style.css';
        project.current_preset_path = '';
        var appdata_preset_path = $appdata_dir + '/' + project.path + '/_Assets_/preset';
        create_folder_cascade(appdata_preset_path.replace(/\//g, '\\'));
        function load_file(file) {
            return load_text_file(project.path + '/' + file);
        };
        project.load_desc = function() {
            return load_file('_Assets_/desc.json');
        };
        project.load_html = function() {
            return load_file('_Assets_/intro.html');
        };
        project.load_config = function() {
            var jscfg = load_file('_Assets_/config.js')
            if (jscfg == '') {
               set_default_preset(project, 'custom');
               init_current_preset(project);
            } else {
              eval(jscfg);
            }
        };
        project.load_presets = function() {
            var arr = get_files(project.path + '/_Assets_/preset');
            arr = arr.concat(get_files(appdata_preset_path));
            arr.sort();
            return arr;
        };
        project.preset_path = function(preset) {
            var path = project.path + '/_Assets_/preset/' + preset + '.js';
            if (fso.FileExists($appdata_dir + '/' + path)) {
                return $appdata_dir + '/' + path;
            }
            return path;
        };
        project.full_preset_path = function(preset) {
            return project.app_root + '/' + project.preset_path(preset);
        }
        project.desc = project.load_desc();
        project.html = project.load_html();
        var $patches_opt = {};
        $patches_preset = 'default';
        project.load_config();
        if (preset) {
            $patches_preset = preset;
        }
        project.presets = project.load_presets();
        project.preset = '-';
        if ($patches_preset != '') {
            var str = load_text_file(project.full_preset_path($patches_preset));
            eval(expand_opt_val(str));
            project.preset = $patches_preset;
        }
        if (typeof(patches_node_init) == 'function') {
            project.patches_node_init = patches_node_init;
        }
        if (typeof(patches_state_init) == 'function') {
            project.patches_state_init = patches_state_init;
        }
        project.patches_opt = $patches_opt;
        if (!lazy) {
            project.patches_tree_data = Project.GetPatches(project);
        }
        return project;
    },
    GetPatches:function(project) {
        function init_patch(rootdir, pdir, pid, cdir, name, arr, type, parent_selected) {
            var cid = pdir + '/' + name;
            if (pid == '#') cid = name;

            if (type == 'link' && !fso.FileExists(cdir + '/' + name + '/main.html')) {
                return;
            }
            var state_opened = false;
            var state_selected = true;
            var def_conf = load_utf8_file(cdir + '/' + name + '/en-US.js');
            var i18n = load_utf8_file(cdir + '/' + name + '/' + $lang + '.js');

            var patch_name = null;
            var patch_opened = null;
            var patch_selected = null;
            var patch_hidden = false;
            // fallback
            if (i18n == '') {
                i18n = def_conf;
            } else {
                i18n = def_conf + '\r\n' + i18n;
            }
            if (i18n != '') eval(i18n);

            if (patch_hidden) {
                return null;
            }

            if (patch_name != null) {
                name = patch_name;
            } else {
                var pos = name.indexOf('-');
                if (pos >= 0) name = name.substring(pos + 1);
            }
            if (patch_opened != null) state_opened = patch_opened;
            if (patch_selected != null) {
                state_selected = patch_selected;
            } else if (parent_selected == false) {
                state_selected = false;
            }

            cdir = cid;
            if (type == 'link') cid = cid + ".LINK";
            var item = { "id" : cid , "parent" : pid, "text" : name,
                "state": {opened: state_opened, checked: state_selected} };
            if (cid == '_CustomFiles_' || pid == '_CustomFiles_') {
                arr[0].push(item);
            } else {
                arr.push(item);
            }
            var node_selected = get_sub_patches(rootdir, cdir, cid, arr, type, state_selected);
            if (node_selected == false) item["state"]["checked"] = false;
            return node_selected;
        };
        function get_sub_patches(rootdir, pdir, pid, arr, type, parent_selected) {
            var has_subpatch = false;
            var state = true;
            var state_selected = true;
            var cdir = rootdir + '/' + pdir;
            if (pid == '#') cdir = pdir;

            var folder = fso.GetFolder(cdir);
            var fenum = new Enumerator(folder.SubFolders);
            for (var i = 0 ; !fenum.atEnd();i++) {
                var name = fenum.item().Name;
                if (fso.FileExists(cdir + '/' + name + '/main.html')) {
                    state = init_patch(rootdir, pdir, pid, cdir, name, arr, type, parent_selected);
                    if (state == false) state_selected = false;
                    has_subpatch = true;
                } else if (fso.FileExists(cdir + '/' + name + '/link')) {
                    var linkrootdir = rootdir.replace('Projects/', $appdata_dir + '/Projects/');
                    var linkpdir = pdir.replace('Projects/', $appdata_dir + '/Projects/');
                    var linkcdir = cdir.replace('Projects/', $appdata_dir + '/Projects/');
                    state = init_patch(linkrootdir, linkpdir, pid, linkcdir, name, arr, 'link', parent_selected);
                    if (state == false) state_selected = false;
                    has_subpatch = true;
                }
                fenum.moveNext();
            }
            if (has_subpatch) return state_selected;
            return parent_selected;
        };
        var arr = new Array();
        var prior_arr = new Array();
        var rootdir = project.path;
        arr.push(prior_arr);
        get_sub_patches(rootdir, rootdir, '#', arr);
        arr.shift();
        if (prior_arr.length > 0) {
            arr = prior_arr.concat(arr);
        }

        if (typeof(project.patches_node_init) == 'function') {
            arr = project.patches_node_init(arr);
        }
        return arr;
    }
}

function set_default_preset(project, preset) {
    if (fso.FileExists(project.appdata_full_path + '/_Assets_/preset/' + preset + '.js')) {
        $patches_preset = preset;
    } else if (fso.FileExists(project.full_path + '/_Assets_/preset/' + preset + '.js')) {
        $patches_preset = preset;
    }
}

function init_current_preset(project) {
    if (!$app_save_current_preset) return;
    project.current_preset_path = project.appdata_full_path + '/_Assets_/preset/current.js';
    if (!fso.FileExists(project.current_preset_path)) {
        var preset_path = project.full_preset_path($patches_preset);
        if (fso.FileExists(preset_path)) {
            fso.CopyFile(preset_path, project.current_preset_path);
        } else {
            save_text_file(project.current_preset_path, '// created by init_current_preset');
        }
    }
    $patches_preset = 'current';
}

function saveas_current_preset(project, name) {
    if (!$app_save_current_preset) return;
    if (fso.FileExists(project.current_preset_path)) {
        fso.CopyFile(project.current_preset_path, project.appdata_full_path + '/_Assets_/preset/' + name + '.js');
        // update presets
        project.presets = project.load_presets();
        update_preset_list(true);
    }
}

function remove_tree_node(items, id) {
    var i = items.length - 1;
    var item = null;
    for(i;i>=0;i--) {
        item = items[i];
        if (item['id'].indexOf(id) == 0) {
            items.splice(i, 1);
        }
    }
}

function pj_button(name) {
    return '<button ' + ' id="pj_' + name + '"' +
        ' class="pure-button pure-button-primary project-button">' +
        name + '</button><br/>';
}