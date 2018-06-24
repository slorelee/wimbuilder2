objArgs = WScript.Arguments
for (i = 0; i < objArgs.length; i++) {
   WScript.Echo('ARGUMENTS('+ i+ '):' + objArgs(i))
}
var file = objArgs(0)
var code_file = objArgs(1)
var code_word = objArgs(2)

var fso = new ActiveXObject("Scripting.FileSystemObject")
var ForReading = 1, ForWriting = 2
var f = fso.OpenTextFile(file, ForReading)
var txt = f.readAll()
f.Close()

var TXT = new text_processor(txt);

if (typeof(locales_script) == 'undefined') {
    main();
}

function main() {

    var codes = load_codes();
    eval(codes);

    f = fso.OpenTextFile(file, ForWriting)
    f.Write(TXT.text);
    f.Close();
}

function load_codes() {
    f = fso.OpenTextFile(code_file, ForReading)
    var bCode = false;
    var line = '';
    var codes = '';
    line = f.Readline()
    while (!f.AtEndOfStream) {
       line = f.ReadLine()
       if (!bCode && line == 'goto ' + code_word) {
           bCode = true;
       } else if (line == code_word) {
           break;
       } else if (bCode) {
           codes += line + "\r\n";
       }
    }
    f.Close();
    return codes;
}

function text_processor(txt) {
    this.lastfn = '';
    this._exp1 = null;
    this.text = txt;

    this.exp1 = function exp1(str, fn){
        this.lastfn = fn;
        this._exp1 = str;
        return this;
    }

    this.before = function(str) {
        return this.exp1(str, 'before');
    };

    this.after = function(str) {
        return this.exp1(str, 'after');
    };

    this.replace = function replace(str1, str2) {
        if (typeof(str2) == 'undefined') {
            this.text = this.text.replace(this._exp1, str1);
            this._exp1 = null;
            return this;
        }
        this.text = this.text.replace(str1, str2);
        return this;
    }

    this.insert = function insert(str){
        if (this.lastfn == 'after') return this.append(str);
        this.text = this.text.replace(this._exp1, str + "\r\n" + this._exp1);
        this._exp1 = null;
        return this;
    }

    this.append = function append(str){
        if (this._exp1 != null) {
            this.text = this.text.replace(this._exp1, this._exp1 + "\r\n" + str);
            this._exp1 = null;
        } else {
            this.text = this.text + str;
        }
        return this;
    }
}
