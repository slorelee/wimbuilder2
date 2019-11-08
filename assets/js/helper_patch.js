function set_default_option(opt, val) {
    if (!$obj_project) return;
    if ($obj_project.patches_opt[opt]) return;

    $obj_project.patches_opt[opt] = val;
}

function set_option(opt, val) {
    if (!$obj_project) return;
    $obj_project.patches_opt[opt] = val;
}

