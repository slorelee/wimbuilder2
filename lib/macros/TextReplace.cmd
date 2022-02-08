rem NOTICE: can't use // at begin, so use #// to instead
rem ESCAPE: #q => ", #s => #, #p => %, #t => \t, #r => \r, #n => \n

echo [MACRO]TextReplace %*
cscript //nologo "%~dp0\TextReplace.js" %*
