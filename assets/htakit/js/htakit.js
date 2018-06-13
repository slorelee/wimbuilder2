document.write('<script src="assets/htakit/js/uikit-tab.js"></script>');

var htakit_js = ['fso', 'wsh', 'shell'];
for (var i=0;i<htakit_js.length;i++) {
    document.write('<script src="assets/htakit/js/lib/' + htakit_js[i] + '.js"></script>');
}
