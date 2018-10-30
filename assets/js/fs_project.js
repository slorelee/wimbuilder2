var Project = {
    root_path: "Projects",
    New:function(name) {
        var project = {};
        project.name = name;
        project.path = Project.root_path + '/' + name;
        var env = wsh.Environment("PROCESS");
        project.wb_root = env('root').replace(/\\/g, '/');
        function load_file(file) {
            if (!fso.FileExists(project.path + '/' + file)) return '';
            var file = fso.OpenTextFile(project.path + '/' + file, ForReading);
            var text = file.readall();
            file.close();
            return text;
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
                var pos = name.indexOf('-');
                if (pos >= 0) name = name.substring(pos + 1);
                var item = { "id" : cid , "parent" : pid, "text" : name };
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