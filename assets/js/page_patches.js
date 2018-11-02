var _patches_selected_node = null;
var $patch_loaded = false;

function init_radio_opt(elem, patches_opt){
    var key = $(elem).attr('name');
    if (key in patches_opt) {
        if ($(elem).attr("value") == patches_opt[key]) {
            $(elem).prop("checked", true);
        }
    }
}

function init_checkbox_opt(elem, patches_opt){
    var key = $(elem).attr('name');
    if (key in patches_opt) {
        if (true == patches_opt[key]) {
            $(elem).prop("checked", true);
        }
    }
}

function init_image_opt(elem, patches_opt, patch_full_path){
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

function init_text_opt(elem, patches_opt){
    var key = $(elem).attr('name');
    if (key in patches_opt) {
        $(elem).attr("value", patches_opt[key]);
    }
}

function init_patches_opt(patches_opt, patch_full_path) {
 $(".opt_item").each(function(){
    var type = $(this).attr('type');
    if (type == 'radio') {
        init_radio_opt(this, patches_opt);
    } else if (type == 'checkbox') {
        init_checkbox_opt(this, patches_opt);
    } else if (type == 'image') {
        init_image_opt(this, patches_opt, patch_full_path);
    } else if (type == 'text') {
        init_text_opt(this, patches_opt);
    }
  });
}

function update_patches_opt(patches_opt) {
 $(".opt_item").each(function(){
    var type = $(this).attr('type');
    if (type == 'radio') {
        var key = $(this).attr('name');
        if ($(this).prop("checked") == true) {
            patches_opt[key] = $(this).attr("value");
        }
    } else if (type == 'checkbox') {
        var key = $(this).attr('name');
        patches_opt[key] = $(this).prop("checked");
    } else if (type == 'image') {
        var key = $(this).attr('name');
        var src = $(this).attr('src');
        patches_opt[key] = src.replace(/\//g, '\\');
    } else if (type == 'text') {
        var key = $(this).attr('name');
        patches_opt[key] = $(this).attr("value");
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
    if (id in $obj_patches) {
        content = $obj_patches[id];
        $patch_loaded = true;
    } else {
        patch = Patch.New($obj_project, id);
        $patch_loaded = false;
        content = $(patch.html);
        $obj_patches[id] = content;
        need_init = true;
    }
    var patches_opt = $obj_project.patches_opt;
    update_patches_opt(patches_opt);
    $('#patch_html').html(content);
    if (need_init) init_patches_opt(patches_opt, $obj_project.wb_root + patch.path);
    //show_patches_opt(patches_opt);
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

function show_patches_settings() {
    var jstree_data = { "plugins" : ["checkbox"],
    "checkbox": {
                    tie_selection: false,
                    whole_node:false
                },
      'core' : {
        'data' : [
        ]
    } };

    if ($obj_patches == null) {
        $obj_patches = new Object();
        $.jstree.destroy();
        $('#patch_html').html('');
    }

    if ($obj_project) {
        jstree_data['core']['data'] = $obj_project.patches_tree_data;
        $('#patches_tree').jstree(jstree_data);
        $('#patches_tree').on("select_node.jstree", function (e, data) {
           patch_onselect(data.node.id);
        });
    }

    if ($obj_project) {
        if (typeof($obj_project.patches_state_init) == 'function') {
           $obj_project.patches_state_init();
        }
    }
}
