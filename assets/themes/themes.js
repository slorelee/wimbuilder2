var $theme_name = '';
var $theme_path = '';
var $theme_canvas = null;

function load_theme_css(theme) {
  $("<link>").attr({
    rel: "stylesheet",
    type: "text/css",
    href: "assets/themes/" + theme + "/css.css"
  }).appendTo("head");
}

function load_theme(theme, force) {
  if (!force && $theme_name != '') return;
  var js_file = 'assets/themes/' + theme + '/js.js';
  if (!fso.FileExists(js_file)) return;

  init_theme_canvas();

  load_theme_css(theme);
  document.write('<script src="' + js_file + '"></script>');
  $theme_name = theme;
  $theme_path = 'assets/themes/' + theme;
}

function themes_loader() {
  if (!$ui_settings['enable_theme_loader']) return;
  var file = 'assets/themes/loader.js';
  if (fso.FileExists(file)) {
    document.write('<script src="' + file + '"></script>');
  }
}

themes_loader();
if ($ui_settings['theme'] != '') {
  load_theme($ui_settings['theme']);
}


function resize_theme_canvas(dy) {
  var dw = window.innerWidth - document.body.clientWidth;
  var ch = document.body.offsetHeight;
  if (!dy) dy = 0;
  if (ch < window.innerHeight) ch = window.innerHeight;
  if (dw > 0) ch += (15 + dy);
  $theme_canvas[0].width = window.innerWidth - dw;
  $theme_canvas[0].height = ch;
}

function init_theme_canvas() {
  $theme_canvas = $("#theme_canvas");

  window.addEventListener("resize", function () {
    resize_theme_canvas();
  })

  $('.pure-menu-link').click(function () {
    resize_theme_canvas(-15);
    resize_theme_canvas();
  });

  resize_theme_canvas();
}
