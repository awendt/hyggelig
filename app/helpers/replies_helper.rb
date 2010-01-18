module RepliesHelper

  # surrounds all but name with a span:
  # e.g. locale is "accepted: {{name}}"
  # "<span>accepted: </span>John Doe"
  def surround_all_but_name(name, i18n_key)
    without_name = I18n.t(:"reply.#{i18n_key}", :name => '')
    I18n.t(:"reply.#{i18n_key}", :name => name).sub(without_name, content_tag(:span, without_name, :class => 'textonly'))
  end

  # renders <li> for a guest,
  # with its class corresponding to her reply
  def list_item_for(guest)
    if guest.is_a?(Reply)
      accepted_declined = guest.attending? ? 'accepted' : 'declined'
      content_tag(:li, surround_all_but_name(h(guest.name), accepted_declined), :class => accepted_declined)
    else
      ""
    end
  end

end
