var checkbox = new Shiny.InputBinding();
$.extend(checkbox, {
  find: function(scope) {
    return $(scope).find('.rpgui-checkbox');
  },
  initialize: function(el) {
    RPGUI.create(el, "checkbox");
  },
  getValue: function(el) {
    return RPGUI.get_value(el);
  },
  setValue: function(el, value) {
    RPGUI.set_value(el, value);
  },
  receiveMessage: function(el, data) {
    this.setValue(el, data);
    $(el).trigger('change');
  },
  subscribe: function(el, callback) {
    $(el).on('change.checkbox', function(e) {
      callback(true);
    });

  },
  unsubscribe: function(el) {
    $(el).off('.checkbox');
  }
});
Shiny.inputBindings.register(checkbox, 'shinyRPG.checkbox');
