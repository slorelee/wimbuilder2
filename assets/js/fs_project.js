var Project = {
    root_path: "Projects",
    New:function(name) {
        var project = {};
        project.name = name;
        project.path = Project.root_path + '/' + name;
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
        return project;
    }
}

function pj_button(name) {
    return '<button ' + ' id="pj_' + name + '"' +
        ' class="pure-button pure-button-primary project-button">' +
        name + '</button><br/>';
}