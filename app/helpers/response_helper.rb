module ResponseHelper

  def accepted_tag(name)
    without_name = I18n.t(:'response.accepted', :name => '')
    I18n.t(:'response.accepted', :name => name).sub(without_name, content_tag(:span, without_name, :class => 'textonly'))
  end

  def declined_tag(name)
    without_name = I18n.t(:'response.declined', :name => '')
    I18n.t(:'response.declined', :name => name).sub(without_name, content_tag(:span, without_name, :class => 'textonly'))
  end

  def list_item_for(guest)
    if guest.is_a?(Response)
      if guest.attending?
        content_tag(:li, accepted_tag(h(guest.name)), :class => 'confirmed')
      else
        content_tag(:li, declined_tag(h(guest.name)), :class => 'declined')
      end
    else
      ""
    end
  end
end
