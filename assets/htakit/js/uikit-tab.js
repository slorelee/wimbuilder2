(function(window, $, undefined) {
  $.fn.ultab = function(options) {
    var defaults = {
      header:['Item1', 'Item2'],
      active:0
    }
    function regist_click_event(elem, arg) {
       elem.click(arg, function(e) {
          var _this = e.data.parent;
          var ul = e.data.ul;
          var i = e.data.i;
          ul.children('.uk-active').removeClass('uk-active');
          _this.children('.tab-active').removeClass('tab-active');

          $(this).addClass('uk-active');
          _this.children('.tab' + i).addClass('tab-active');

        });
    }
    if (options === true) { /* regist click event only */
      var _this = this;
      var ul = this.children('ul');
      var i = 0;
      ul.children('li').each(function() {
        regist_click_event($(this), {parent:_this, ul:ul, i:i});
        i++;
      });
      return $(_this);
    }
    var options = $.extend(defaults, options);
    this.each(function(){
      var _this = $(this);
      var ul = $('<ul></ul>');
      ul.addClass('uk-tab');
      _this.prepend(ul);

      options.header.forEach(function(item, i) {
        var li = $('<li><a href="#">' + options.header[i] + '</a></li>');
        if (i == options.active) {
          li.addClass('uk-active');
          _this.children('.tab' + i).addClass('tab-active');
        }
        regist_click_event(li, {parent:_this, ul:ul, i:i});
        ul.append(li);
      });
    })
    return $(this);
  }
}(window, jQuery));