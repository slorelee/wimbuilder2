function show_projects() {
    var dirs = get_subdirs('Projects');
    $('#project_list').html("");
    dirs.forEach(function(item) {
        $('#project_list').append(pj_button(item));
    });

    if (selected_project != null) {
        $('#pj_' + selected_project).text(selected_project + '   *');
        $('#pj_' + selected_project).addClass('project-selected');
    }
    regist_event();

    if (dirs.length == 1 && selected_project == null) {
        $('#pj_' + dirs[0]).click();
    }
}

function regist_event() {
    $('.project-button').click(function(){
        var name = $(this).attr('id');
        name = name.substr(3);
        var last_selected_project = selected_project;
        if (selected_project != null) {
            $('#pj_' + selected_project).text(selected_project);
            $('#pj_' + selected_project).removeClass('project-selected');
        }
        selected_project = name;
        $('#pj_' + selected_project).addClass('project-selected');
        $('#pj_' + selected_project).text(name + '   *');
        
        var project = $obj_project;
        if (last_selected_project != selected_project) {
            project = Project.New(name);
            $obj_project = project;
            $obj_patches = null;
        }
        $('#project_desc').html('<p>' + project.desc.replace(/\r\n/g, '<br/>') + '</p>');
        if (project.desc) {
            var obj = JSON.parse(project.desc);
            //alert('read JSON[description]:' + obj.description);
        }
        $('#project_html').html(project.html);
    })
}



function pj_button(name) {
    return '<button ' + ' id="pj_' + name + '"' +
        ' class="pure-button pure-button-primary project-button">' +
        name + '</button><br/>';
}