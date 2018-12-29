@echo off

echo MACRO:TextReplace %*
cscript //nologo "%~dp0\TextReplace.js" %*
