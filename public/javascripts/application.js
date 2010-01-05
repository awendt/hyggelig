// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// From http://scott.sauyet.com/thoughts/archives/2007/03/31/overlabel-with-jquery/#comment-24205
jQuery.fn.overlabel = function() {
  this.filter('label[for]').each(function() {
    var label = $(this);
    var id = label.attr('for');
    var field = $("#" + id);

    if(!field) {
      return;
    }

    label.addClass('overlabel-apply');

    var hide_label = function() { label.css('text-indent', '-10000px'); };
    var show_label = function() { return this.value || label.css('text-indent', '0px'); };
    var show_label_if_empty = function() {
      if (field.val() && field.val().length > 0) {
        hide_label();
      } else {
        show_label();
      }
    };

    $(field).focus(hide_label).blur(show_label).each(show_label_if_empty);

    return;
  });
};


$(document).ready(function() {
  $("label.overlabel").overlabel();
  $("#event_name").change(function() {
    $.ajax({
      url: '/event/preview_url',
      async: true,
      type: 'POST',
      data: {event_name: $("#event_name").val()},
      success: function(markup) {
        $("#event_name_hint").html(markup);
      }
    });
  });
  $("#create input[type=submit]").click(function() {
    piwikTracker.trackGoal(2);
    return true;
  });
});
