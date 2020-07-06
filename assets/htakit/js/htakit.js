document.write('<script src="htakit/js/uikit-tab.js"></script>');

var htakit_js = ['wsh', 'fso', 'shell'];
for (var i=0;i<htakit_js.length;i++) {
    document.write('<script src="htakit/js/lib/' + htakit_js[i] + '.js"></script>');
}
