var select = new Shiny.InputBinding();
$.extend(select, {
  find: function(scope) {
    return $(scope).find('.rpgui-dropdown') && $(scope).find('.rpgui-list');
  },
  getValue: function(el) {
    return RPGUI.get_value(el);
  },
  setValue: function(el, value) {
    RPGUI.set_value(el, value);
  },
  receiveMessage: function(el, data) {
    this.setValue(el, data.value);
    $(el).trigger('change');
  },
  subscribe: function(el, callback) {
    $(el).on('change.select', function(e) {
      callback();
    });

  },
  unsubscribe: function(el) {
    $(el).off('.select');
  }
});
Shiny.inputBindings.register(select, 'shinyRPG.select');
