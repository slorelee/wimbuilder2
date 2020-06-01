function set_default_option(opt, val) {
    if (!$obj_project) return;
    if ($obj_project.patches_opt[opt] != null) return;

    $obj_project.patches_opt[opt] = expand_opt_val(val, true);
}

function set_option(opt, val) {
    if (!$obj_project) return;
    $obj_project.patches_opt[opt] = expand_opt_val(val, true);
}

function str_replace(str, src, rep) {
    while (str.indexOf(src) != -1) {
        str = str.replace(src, rep);
    }
    return str;
}

function expand_opt_val(val, raw) {
    var env_path = $app_root;
    if (typeof(val) != 'string') return val;
    if (!raw) {
        env_path = $app_root.replace('\\', '\\\\');
    }
    return str_replace(val, '%APP_ROOT%', env_path);
}
