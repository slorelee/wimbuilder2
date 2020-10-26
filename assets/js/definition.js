var selected_project = null;
var $obj_project = null;
var $obj_patches = null;
var $patches_opt = null;
var $patches_var = {};

var $app_host_lang = 'en-US';

var $update_sources = {
    "github":{
        "remote_url":"https://github.com/slorelee/wimbuilder2/releases/download/update",
        "source_url":"https://github.com/slorelee/wimbuilder2/raw/master"
    },
    "gitee":{
        "remote_url":"http://hello.wimbuilder.world/static/releases/WimBuilder2/master",
        "source_url":"https://gitee.com/slorelee/wimbuilder2/raw/master"
    },
    "wimbuilder":{
        "remote_url":"http://hello.wimbuilder.world/static/releases/WimBuilder2/master",
        "source_url":"http://hello.wimbuilder.world/static/releases/WimBuilder2/master"
    },
    "custom":{
        "remote_url":"https://",
        "source_url":"https://"
    }
}
