https://github.com/inexorabletash/polyfill/blob/master/es5.js

// Add ECMA262-5 Array methods if not supported natively
//
if (!('indexOf' in Array.prototype)) {
    Array.prototype.indexOf = function(find, i /*opt*/) {
        if (i === undefined) i = 0;
        if (i < 0) i+= this.length;
        if (i < 0) i = 0;
        for (var n = this.length; i < n; i++)
            if (i in this && this[i] === find)
                return i;
        return -1;
    };
}

if (!('filter' in Array.prototype)) {
    Array.prototype.filter= function(filter, that /*opt*/) {
        var other= [], v;
        for (var i = 0, n = this.length; i < n; i++)
            if (i in this && filter.call(that, v= this[i], i, this))
                other.push(v);
        return other;
    };
}

if (!('forEach' in Array.prototype)) {
    Array.prototype.forEach = function(action, that /*opt*/) {
        for (var i = 0, n = this.length; i < n; i++)
            if (i in this)
                action.call(that, this[i], i, this);
    };
}

/*
var arr = new Array();
arr.push("abc");
alert(arr.length);

//bad, Object.defineProperty also unsupport
for (i in arr) {
  alert(arr[i]); // got indexOf, filter function
}

arr.forEach(function(item, index) { // use forEach() to instead of (for (... in ...)) {}
    alert(index);
    alert(item);
 });
*/