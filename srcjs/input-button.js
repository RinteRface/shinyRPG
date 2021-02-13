var button = new Shiny.InputBinding();
$.extend(button, {
  find: function(scope) {
    return $(scope).find('.rpgui-button')
  },
  getValue: function(el) {
    return parseInt($(el).val()) || 0;
  },
  subscribe: function(el, callback) {
    self = this;
    $(el).on('click.button', function(e) {
      var currentVal = self.getValue(el);
      $(el).val(currentVal + 1);
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off('.button');
  }
});
Shiny.inputBindings.register(button, 'shinyRPG.button');
