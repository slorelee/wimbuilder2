(function(window, $, undefined) {
  $.fn.ultab = function(options) {
    var defaults = {
      header:['Item1', 'Item2'],
      active:0
    }
    var options = $.extend(defaults, options);
    this.each(function(){
      var _this = $(this);
      var ul = $('<ul></ul>');
      ul.addClass('uk-tab');
      _this.prepend(ul);

      for (var i in options.header) {
        var li = $('<li><a href="#">' + options.header[i] + '</a></li>');
        if (i == options.active) {
          li.addClass('uk-active');
          _this.children('.tab' + i).addClass('tab-active');
        }
        li.click({parent:_this, ul:ul, i:i}, function(e) {
          var _this = e.data.parent;
          var ul = e.data.ul;
          var i = e.data.i;
          ul.children('.uk-active').removeClass('uk-active');
          _this.children('.tab-active').removeClass('tab-active');

          $(this).addClass('uk-active');
          _this.children('.tab' + i).addClass('tab-active');

        });
        ul.append(li);
      }
    })
    return $(this);
  }
}(window, jQuery));