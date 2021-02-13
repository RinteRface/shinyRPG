var button = new Shiny.InputBinding;

$.extend(button, {
    find: function(scope) {
        return $(scope).find(".rpgui-button");
    },
    getValue: function(el) {
        return parseInt($(el).val()) || 0;
    },
    subscribe: function(el, callback) {
        self = this;
        $(el).on("click.button", (function(e) {
            var currentVal = self.getValue(el);
            $(el).val(currentVal + 1);
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".button");
    }
});

Shiny.inputBindings.register(button, "shinyRPG.button");

var slider = new Shiny.InputBinding;

$.extend(slider, {
    find: function(scope) {
        return $(scope).find(".rpgui-slider");
    },
    initialize: function(el) {
        RPGUI.create(el, "slider");
    },
    getValue: function(el) {
        return parseInt(RPGUI.get_value(el));
    },
    setValue: function(el, value) {
        RPGUI.set_value(el, value);
    },
    receiveMessage: function(el, data) {
        this.setValue(el, data);
        $(el).trigger("change");
    },
    subscribe: function(el, callback) {
        $(el).on("change.slider", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".slider");
    }
});

Shiny.inputBindings.register(slider, "shinyRPG.slider");

$((function() {
    $(".rpgui-progress").each((function() {
        let config = $(document).find("script[data-for='" + this.id + "']");
        let val = JSON.parse(config.html());
        RPGUI.set_value(this, val);
    }));
    Shiny.addCustomMessageHandler("update-progress", (function(message) {
        let $el = document.getElementById(message.id);
        if (message.hasOwnProperty("value")) {
            RPGUI.set_value($el, message.value);
        }
    }));
}));
