$(document).ready(function () {
    $(document).on('shiny:connected', function (event) {
        Shiny.unbindAll();
        $.extend(Shiny
            .inputBindings
            .bindingNames['shiny.radioInput']
            .binding, {
            subscribe: function (el, callback) {
                // added click event ...
                $(el).on('click.radioInputBinding change.radioInputBinding', function (e) {
                    callback();
                });
            }
        });
        Shiny.bindAll();
    });
});
