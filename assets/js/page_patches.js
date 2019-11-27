var _patches_selected_node = null;
var $patches_preset_inited = null;
var $patch_loaded = false;
var $obj_patch = null;

var _patch_updater = [];

var _saved_current_preset = true;
var _jstree_selected_node = null;

function init_radio_opt(elem, patches_opt) {
    var key = $(elem).attr('name');
    if (key in patches_opt) {
        if ($(elem).attr("value") == patches_opt[key]) {
            $(elem).prop("checked", true);
        }
    }
}

function init_checkbox_opt(elem, patches_opt) {
    var key = $(elem).attr('name');
    if (key in patches_opt) {
        $(elem).prop("checked", true == patches_opt[key]);
    }
}

function init_image_opt(elem, patches_opt, patch_full_path) {
    var update = $(elem).attr('update');
    var key = $(elem).attr('name');
    var src = $(elem).attr('src');
    if (key in patches_opt) {
        src = patches_opt[key];
    }
    if (update == "src") {
        if (src.substring(2, 1) !== ':') {
            //src = src.replace(/$patch_path/, patch_full_path);
            src = patch_full_path + '/' + src;
        }
        $(elem).attr('src', src);
    }
}

function init_text_opt(elem, patches_opt) {
    var key = $(elem).attr('name');
    if (key in patches_opt) {
        $(elem).val(patches_opt[key]);
    }
}

function init_select_opt(elem, patches_opt){
    var key = $(elem).attr('name');
    if (key in patches_opt) {
        $(elem).val(patches_opt[key]);
        //jquery-ui selectmenu
        var inst = ($(elem).selectmenu("instance"));
        if (typeof(inst) != "undefined") {
            $(elem).selectmenu("refresh");
        }
    }
}

function init_spinbutton_opt(elem, patches_opt){
    var key = $(elem).attr('name');
    if (key in patches_opt) {
        $(elem).spinner("value", patches_opt[key]);
    }
}

function init_patches_opt(patches_opt, patch_full_path) {
 $(".opt_item").each(function() {
    var type = $(this)[0].tagName.toLowerCase();
    if (type == 'input') type = $(this).attr('type');
    if (typeof(type) == 'undefined') {
        //jquery-ui spinner
        if ($(this).hasClass('ui-spinner-input')) {
            type = 'spinbutton';
        }
    }
    if (type == 'radio') {
        init_radio_opt(this, patches_opt);
    } else if (type == 'checkbox') {
        init_checkbox_opt(this, patches_opt);
    } else if (type == 'image') {
        init_image_opt(this, patches_opt, patch_full_path);
    } else if (type == 'text') {
        init_text_opt(this, patches_opt);
    } else if (type == 'select') {
        init_select_opt(this, patches_opt);
    } else if (type == 'spinbutton') {
        init_spinbutton_opt(this, patches_opt);
    }
  });
}

function patch_updater_register(func) {
    _patch_updater.push(func);
}

function patch_updater_execute(keep_updater) {
    if (_patch_updater.length == 0) return;
    _patch_updater.forEach(function(func) {
        func();
    });
    if (!keep_updater) _patch_updater.length = 0;
}

function update_patches_opt(patches_opt, keep_updater) {
  patch_updater_execute(keep_updater);
  $(".opt_item").each(function() {
    var type = $(this)[0].tagName.toLowerCase();
    if (type == 'input') type = $(this).attr('type');
    if (typeof(type) == 'undefined') {
        //is jquery-ui spinner?
        type = $(this).attr('role'); //spinbutton
    }
    var key = $(this).attr('name');
    if (type == 'radio') {
        if ($(this).prop("checked") == true) {
            patches_opt[key] = $(this).attr("value");
        }
    } else if (type == 'checkbox') {
        patches_opt[key] = $(this).prop("checked");
    } else if (type == 'image') {
        var src = $(this).attr('src');
        patches_opt[key] = src.replace(/\//g, '\\');
    } else if (type == 'text') {
        var key = $(this).attr('name');
        patches_opt[key] = $(this).val();
    } else if (type == 'select') {
        var val = $(this).children("option:selected").text();
        patches_opt[key] = val;
    } else if  (type == 'spinbutton') {
        patches_opt[key] = $(this).spinner("value");
    }
  });
}

function show_patches_opt(patches_opt) {
    alert(JSON.stringify(patches_opt));
}

function patch_onselect(id) {
    if (_patches_selected_node == id) return;
    _patches_selected_node = id;
    var patch = null;
    var content = null;
    var need_init = false;

    update_patches_opt($patches_opt);
    if (id in $obj_patches) {
        $obj_patch = $obj_patches[id];
        content = $obj_patch.content;
        $patch_loaded = true;
        patch = $obj_patches[id];
    } else {
        patch = Patch.New($obj_project, id);
        $obj_patch = patch;
        $patch_loaded = false;
        var html = patch.html;
        if ($IE_VER != '9+') {
            html = html.replace(/onoffswitch-checkbox/g, 'onoffswitch-checkbox_DIS');
        }
        content = $(html);
        patch.content = content;
        $obj_patches[id] = patch;
        need_init = true;
    }
    $('#patch_html').html(content);
    if (need_init) init_patches_opt($patches_opt, $obj_project.wb_root + '/' + patch.path);
    //show_patches_opt($patches_opt);
}

function open_tree_node(id) {
  $('#patches_tree').jstree(true).open_node(id);
}

function close_tree_node(id) {
  $('#patches_tree').jstree(true).close_node(id);
}

function check_tree_node(id) {
  $('#patches_tree').jstree(true).check_node(id);
}

function uncheck_tree_node(id) {
  $('#patches_tree').jstree(true).uncheck_node(id);
}

function select_tree_node(id) {
  $('#patches_tree').jstree(true).select_node(id);
}

function deselect_tree_node(id) {
  $('#patches_tree').jstree(true).deselect_node(id);
}

var _editor_notice_done = false;
function edit_menu_action(file) {
  var editor = $obj_project.full_path + '/_CustomFiles_/editor.cmd';
  if ($_wb_first_run) {
    if (!_editor_notice_done) {
      var msg = i18n_t('Will open file with notepad.exe, You can edit [%s] file to change the editor.');
      msg = msg.replace('%s', editor);
      alert(msg);
      _editor_notice_done = true;
    }
  }
  if (!fso.FileExists(file)) return;
  var style = 0;
  if (!fso.FileExists(editor)) {
    editor = 'notepad.exe';
    style = 1;
  }
  file = file.replace(/\//g, '\\');
  Run(editor, '\"' + file + '\"', style);
}

function update_preset_list() {
    if ($patches_preset_inited) return;

    var preset_selected = false;
    $('#patch_preset').empty();
    $obj_project.presets.forEach(function(preset) {
        var preset_name = preset.slice(0, -3);
        if ($obj_project.preset == preset_name) {
            $('#patch_preset').append('   <option selected>' + preset_name + '</option>');
            preset_selected = true;
        } else {
            $('#patch_preset').append('   <option>' + preset_name + '</option>');
        }
    });
    if (preset_selected) {
        $('#patch_preset').append('   <option>-</option>');
    } else {
        $('#patch_preset').append('   <option selected>-</option>');
    }
    $patches_preset_inited = true;
}

function show_patches_settings() {
    var jstree_data = { "plugins" : ["checkbox", "contextmenu"],
    "checkbox": {
                    tie_selection: false,
                    whole_node:false
                },
    "contextmenu":{
            select_node:false,
            show_at_node:false,
            items: {
            },
      },
      'core' : {
        'data' : [
        ]
    } };

    var patches_tree_loaded = true;
    if ($obj_patches == null) {
        $obj_patches = new Object();
        $.jstree.destroy();
        $('#patch_html').html('');
        patches_tree_loaded = false;
    }

    if ($obj_project) {
        jstree_data['core']['data'] = $obj_project.patches_tree_data;
        jstree_data['contextmenu']['items'] = {
            "OpenFolder": {
                "label": i18n_t("OpenFolder"),
                "icon": "browse",
                "action": function(data) {
                    var inst = $.jstree.reference(data.reference),
                    obj = inst.get_node(data.reference);
                    OpenFolder($obj_project.full_path + '/' + obj.id);
                }
            },
            "EditMain": {
                "label": i18n_t("Edit main.bat"),
                "icon": "edit",
                "action": function(data) {
                    var inst = $.jstree.reference(data.reference),
                    obj = inst.get_node(data.reference);
                    edit_menu_action($obj_project.full_path + '/' + obj.id + '/main.bat');
                }
            },
            "EditLast": {
                "label": i18n_t("Edit last.bat"),
                "icon": "edit",
                "action": function(data) {
                    var inst = $.jstree.reference(data.reference),
                    obj = inst.get_node(data.reference);
                    edit_menu_action($obj_project.full_path + '/' + obj.id + '/last.bat');
                }
            },
        };
        $('#patches_tree').jstree(jstree_data);
        $('#patches_tree').on("select_node.jstree", function (e, data) {
           patch_onselect(data.node.id);
        });
    }

    if ($obj_project && !patches_tree_loaded) {
        if (typeof($obj_project.patches_state_init) == 'function') {
           $obj_project.patches_state_init();
        }
    }
    _saved_current_preset = false;
}

function get_tmp_folder(project) {
    var env = wsh.Environment("PROCESS");
    var tmp_path = env('Factory') + "\\tmp\\" + project;
    create_folder_cascade(tmp_path);
    return tmp_path;
}

function patches_opt_stringify(line) {
    var str = JSON.stringify($obj_project.patches_opt);
    if (line == null) line = "<br\/>";
    str = str.replace(/("[^"]+?":".*?",)/g, "$1" + line);
    str = str.replace(/("[^"]+?":[^"]+?,)/g, "$1" + line);
    return str;
}

function dump_patches_selected() {
    var tmp_folder = get_tmp_folder($obj_project.name);
    var patches_undetermined = $('#patches_tree').jstree(true).get_undetermined();
    var patches_selected = $('#patches_tree').jstree(true).get_checked();
    patches_selected = patches_undetermined.concat(patches_selected);
    var str = '';
    patches_selected = patches_selected.sort();
    for(var patch_id in patches_selected) {
        str += patches_selected[patch_id] + "\r\n";
    }
    str = str.replace(/\//g, "\\");
    if (str.indexOf("\r\n_CustomFiles_\r\n") != -1) {
        str = "_CustomFiles_\r\n" + str.replace("\r\n_CustomFiles_\r\n", "\r\n");
    }
    save_text_file(tmp_folder + "\\_patches_selected.txt", str);
    return str;
}

function str_replace(str, src, rep) {
    while (str.indexOf(src) != -1) {
        str = str.replace(src, rep);
    }
    return str;
}

function dump_patches_opt() {
    var options = $obj_project.patches_opt;
    var tmp_folder = get_tmp_folder($obj_project.name);
    var str = '', opt_str = '', rep_str = '';
    for(var key in options) {
        opt_str = "set \"opt[" + key + "]=" + options[key] + "\"\r\n";
        rep_str = opt_str.replace($wb_root + '\\', "%%WB_ROOT%%\\");

        if (opt_str != rep_str) {
            opt_str = 'call ' + rep_str;
        }
        str += opt_str;
    }
    //str = str_replace(str, $wb_root + '\\', "%%WB_ROOT%%\\");
    save_text_file(tmp_folder + "\\_patches_opt.bat", str);
    return str;
}


function get_nodetree_status(node, arr, patches_undetermined){
    node.forEach(function(item) {
        get_node_status(item, arr, patches_undetermined);
    });
}

// "state":{"loaded":true,"opened":false,"selected":false,"disabled":false,"checked":true}
function get_node_status(node, arr, undetermined_arr){
    //alert(JSON.stringify(node));

    if (node['state']['checked']) {
        arr.push(':C:' + node['id']);
    } else {
        var i = undetermined_arr.indexOf(node['id']);
        if (i > -1) {
            undetermined_arr.splice(i, 1);
            get_nodetree_status(node['children'], arr, undetermined_arr);
        } else {
            arr.push(':U:' + node['id']);
        }
    }

    if (node['state']['selected']) {
        _jstree_selected_node = node['id'];
        arr.push(':S:' + node['id']);
    }

    if (node['state']['opened']) {
        arr.push(':O:' + node['id']);
    }
}

function get_jstree_status(){
    var patches_undetermined = $('#patches_tree').jstree(true).get_undetermined();
    var patches_json = $('#patches_tree').jstree(true).get_json();
    var arr = [];
    _jstree_selected_node = '';
    get_nodetree_status(patches_json, arr, patches_undetermined);
    if (_jstree_selected_node == '') {
        if (_patches_selected_node) {
            arr.push(':S:' + _patches_selected_node);
        }
    }
    var str = arr.join("\");\r\n") + "\");\r\n";
    str = str.replace(/:O:/g, 'open_tree_node(\"');
    str = str.replace(/:S:/g, 'select_tree_node(\"');
    str = str.replace(/:C:/g, 'check_tree_node(\"');
    str = str.replace(/:U:/g, 'uncheck_tree_node(\"');
    return str;
}

function save_current_preset(collected){
    if (!$obj_project) return;
    if (!$wb_save_current_preset) return;
    if (_saved_current_preset) return;

    if (!collected) {
        update_patches_opt($obj_project.patches_opt, true);
    }

    // patches_opt
    var str = "var $patches_opt = {\r\n";
    str = str + patches_opt_stringify("\r\n").slice(1, -1) + ",\r\n";
    str = str.replace(/"_[^"]+?":.+?,\r\n/g, "");
    str = str + '"_._._":""' + "\r\n}\r\n\r\n";

    // function patches_state_init() {
    str = str + "function patches_state_init() {\r\n";
    str = str + get_jstree_status();
    str = str + "}\r\n";

    save_text_file($obj_project.current_preset_path, str);
    _saved_current_preset = true;
}

$('#patch_preset').change(function(){
    if (!$obj_project) return;
    //reload project with the preset
    var preset = $(this).children("option:selected").text();
    if (preset == '-') return;
    reload_project(selected_project, preset);
    $patches_preset_inited = true;
    $patches_preset = preset;
    _patches_selected_node = null;

    $('#menu_patch').click();
});

