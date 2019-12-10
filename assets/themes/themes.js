
function load_theme_css(theme) {
$("<link>").attr({ rel: "stylesheet",
type: "text/css",
href: "assets/themes/" + theme + "/" + theme + ".css"
}).appendTo("head");
}

function load_theme(theme) {
  load_theme_css(theme);
  document.write('<script src="assets/themes/' + theme + '/' + theme + '.js"></script>');
}

function themes_loader() {
  var file = 'assets/themes/loader.js';
  if (fso.FileExists(file)) {
    document.write('<script src="' + file + '"></script>');
  }
}

themes_loader();
