$(function() {

  // Initialize all progress bars
  $(".rpgui-progress").each(function() {
    let config = $(document).find(
      "script[data-for='" + this.id + "']"
    );
    let val = JSON.parse(config.html());
    RPGUI.set_value(this, val);
  });

  // Update progress bar
  Shiny.addCustomMessageHandler('update-progress', function(message) {
    let $el = document.getElementById(message.id);
    // update value
    if (message.hasOwnProperty("value")) {
      RPGUI.set_value($el, message.value);
    }
  });
});
