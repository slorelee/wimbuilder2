function BrowseFile(elem) {
    var f = document.getElementById('$f');
    f.value = '';
    f.click();
    if (!elem) return f.value;
    $(elem).val(f.value);
}
