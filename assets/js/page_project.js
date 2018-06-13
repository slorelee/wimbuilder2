function show_projects() {
    var dirs = get_subdirs('Projects');
    $('#project_list').html("");
    for (i in dirs) {
        $('#project_list').append(pj_button(dirs[i]));
    }
    if (selected_project != null) {
        $('#pj_' + selected_project).text(selected_project + '   *');
        $('#pj_' + selected_project).addClass('project-selected');
    }
    regist_event();
}

function regist_event() {
    $('.project-button').click(function(){
        var name = $(this).attr('id');
        name = name.substr(3);
        if (selected_project != null) {
            $('#pj_' + selected_project).text(selected_project);
            $('#pj_' + selected_project).removeClass('project-selected');
        }
        selected_project = name;
        $('#pj_' + selected_project).addClass('project-selected');
        $('#pj_' + selected_project).text(name + '   *');
        var project = Project.New(name);
        $('#project_desc').html('<p>' + project.desc + '</p>');
        if (project.desc) {
            var obj = JSON.parse(project.desc);
            alert('read JSON[description]:' + obj.description);
        }
        $('#project_html').html(project.html);
    })
}



function pj_button(name) {
    return '<button ' + ' id="pj_' + name + '"' +
        ' class="pure-button pure-button-primary project-button">' +
        name + '</button><br/>';
}