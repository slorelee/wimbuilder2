var _patches_selected_node = null;

function init_patches_opt(patches_opt, patch_full_path) {
 $(".opt_item").each(function(){
    var type = $(this).attr('type');
    if (type == 'radio') {
        var key = $(this).attr('name');
        if (key in patches_opt) {
            if ($(this).attr("value") == patches_opt[key]) {
                $(this).prop("checked", true);
            }
        }
    } else if (type == 'checkbox') {
        var key = $(this).attr('name');
        if (key in patches_opt) {
            if (true == patches_opt[key]) {
                $(this).prop("checked", true);
            }
        }
    } else if (type == 'image') {
        var update = $(this).attr('update');
        var key = $(this).attr('name');
        var src = $(this).attr('src');
        if (key in patches_opt) {
            src = patches_opt[key];
        }
        if (update == "src") {
            if (src.substring(2, 1) !== ':') {
                //src = src.replace(/$patch_path/, patch_full_path);
                src = patch_full_path + '/' + src;
            }
            $(this).attr('src', src);
        }
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
    } else {
        patch = Patch.New($obj_project, id);
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
}
