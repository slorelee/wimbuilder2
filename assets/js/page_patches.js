var _patches_selected_node = null;

function patch_onselect(id) {
    if (_patches_selected_node == id) return;
    _patches_selected_node = id;
    var patch = null;
    var content = null;
    if (id in $obj_patches) {
        content = $obj_patches[id];
    } else {
        patch = Patch.New($obj_project, id);
        content = $(patch.html);
        $obj_patches[id] = content;
    }
    $('#patch_html').html(content);
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
