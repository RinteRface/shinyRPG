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

var checkbox = new Shiny.InputBinding;

$.extend(checkbox, {
    find: function(scope) {
        return $(scope).find(".rpgui-checkbox");
    },
    initialize: function(el) {
        RPGUI.create(el, "checkbox");
    },
    getValue: function(el) {
        RPGUI.set_value(el, $(el).prop("checked"));
        return RPGUI.get_value(el);
    },
    setValue: function(el, value) {
        RPGUI.set_value(el, value);
    },
    receiveMessage: function(el, data) {
        this.setValue(el, data);
        $(el).trigger("change");
    },
    subscribe: function(el, callback) {
        $(el).on("change.checkbox", (function(e) {
            callback(true);
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".checkbox");
    }
});

Shiny.inputBindings.register(checkbox, "shinyRPG.checkbox");

Shiny.inputBindings.setPriority("shinyRPG.checkbox", 10);

var select = new Shiny.InputBinding;

$.extend(select, {
    find: function(scope) {
        return $(scope).find(".rpgui-dropdown") && $(scope).find(".rpgui-list");
    },
    getValue: function(el) {
        return RPGUI.get_value(el);
    },
    setValue: function(el, value) {
        RPGUI.set_value(el, value);
    },
    receiveMessage: function(el, data) {
        this.setValue(el, data.value);
        $(el).trigger("change");
    },
    subscribe: function(el, callback) {
        $(el).on("change.select", (function(e) {
            callback();
        }));
    },
    unsubscribe: function(el) {
        $(el).off(".select");
    }
});

Shiny.inputBindings.register(select, "shinyRPG.select");

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

$(document).ready((function() {
    $(document).on("shiny:connected", (function(event) {
        Shiny.unbindAll();
        $.extend(Shiny.inputBindings.bindingNames["shiny.radioInput"].binding, {
            subscribe: function(el, callback) {
                $(el).on("click.radioInputBinding change.radioInputBinding", (function(e) {
                    callback();
                }));
            }
        });
        Shiny.bindAll();
    }));
}));

$((function() {
    $(".rpgui-progress").each((function() {
        let config = $(document).find("script[data-for='" + this.id + "']");
        let val = JSON.parse(config.html());
        RPGUI.set_value(this, val);
    }));
    Shiny.addCustomMessageHandler("update-progress", (function(message) {
        let $el = document.getElementById(message.id);
        if (message.hasOwnProperty("color")) {
            let val = parseInt($el.children[1].children[0].style["width"]);
            let newElHTML = `<div\n        id="${message.id}"\n        class="rpgui-progress ${message.color}"\n        ></div>`;
            $(newElHTML).insertAfter($($el));
            $($el).remove();
            $el = document.getElementById(message.id);
            RPGUI.create($el, "progress");
            RPGUI.set_value($el, val / 100);
        }
        if (message.hasOwnProperty("value")) {
            RPGUI.set_value($el, message.value);
        }
    }));
}));
