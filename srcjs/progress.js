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
    // Update color
    if (message.hasOwnProperty("color")) {
      // recover old value
      let val = parseInt($el.children[1].children[0].style["width"]);
      // update color
      let newElHTML = `<div
        id="${message.id}"
        class="rpgui-progress ${message.color}"
        ></div>`;
      // Insert new HTML after old instance (position does not matter since old instance
      // will be remove anyway ...)
      $(newElHTML).insertAfter($($el));
      // Remove old instance
      $($el).remove();
      // Update reference to clean instance data
      $el = document.getElementById(message.id);
      // Initialize new instance
      RPGUI.create($el, "progress");
      // Set old value
      RPGUI.set_value($el, val / 100);
    }
    // update value
    if (message.hasOwnProperty("value")) {
      RPGUI.set_value($el, message.value);
    }
  });
});
