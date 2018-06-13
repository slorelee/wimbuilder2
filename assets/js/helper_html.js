function wbcode_browsefolder(opt, text) {
    var id = '', tooltip = '', title = '';
    var res = opt.match(/id=\"(.+?)\"/i);
    if (res) { id = res[1];}
    res = opt.match(/tooltip=\"(.+?)\"/i);
    if (res) {tooltip = ' title="'+ res[1] + '"';}
    res = opt.match(/title=\"(.+?)\"/i);
    if (res) {title = res[1];}
    return '<a href="#" class="ibutton browse"' + tooltip + ' onclick="$(\'#'+ id + '\').val(BrowseFolder(\''+ title + '\'))">' + text + '</a>';
}

function wbcode_browsefolders(wbcode) {
    var result = wbcode;
    var regexp = /\[browsefolder ([^\[]+)\]\(([^\(]+)\)/g;
    while (bf = regexp.exec(wbcode)) {
        result = result.replace(bf[0], wbcode_browsefolder(bf[1], bf[2]));
    }
    return result;
}

function wbcode(id) {
    var elem = document.getElementById(id);
    var tmp = elem.innerHTML;
    tmp = tmp.replace(/\[b\](.+?)\[\/b\]/g, '<b>$1</b>');
    tmp = tmp.replace(/\[p\](.+?)\[\/p\]/g, '<p>$1</p>');
    tmp = tmp.replace(/\[color=(.+)\]([^\[]+)\[\/color\]/g, '<font color="$1">$2</font>');
    tmp = tmp.replace(/\[size=(.+)\]([^\[]+)\[\/size\]/g, '<font size="$1">$2</font>');

    tmp = tmp.replace(/\[text(.+?)\]\((.+?)\)/g, '<input type="text" $1 value="$2" />');
    tmp = wbcode_browsefolders(tmp);

    tmp = tmp.replace(/\[(.+?)\]\((.+?)\)/g, '<a href="$2" target="_blank">$1</a>');

    tmp = tmp.replace(/\[br\]/g, '<br/>');
    elem.innerHTML = tmp;
    //elem.id  = '';
}