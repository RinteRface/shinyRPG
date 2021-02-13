var slider = new Shiny.InputBinding();
$.extend(slider, {
  initialize: function(el) {
    RPGUI.create(el, "slider");
  },
  find: function(scope) {
    return $(scope).find('.rpgui-slider');
  },
  getValue: function(el) {
    return parseInt(RPGUI.get_value(el));
  },
  setValue: function(el, value) {
    RPGUI.set_value(el, value);
  },
  receiveMessage: function(el, data) {
    this.setValue(el, data);
    $(el).trigger('change');
  },
  subscribe: function(el, callback) {
    $(el).on('change.slider', function(e) {
      callback();
    });

  },
  unsubscribe: function(el) {
    $(el).off('.slider');
  }
});
Shiny.inputBindings.register(slider, 'shinyRPG.whatever');
