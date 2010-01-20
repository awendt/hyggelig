module EventsHelper

  def url_preview_for(name)
    if name.blank?
      I18n.t(:'event.url_preview_empty')
    else
      I18n.t(:'event.name_url_preview', :url => content_tag(:strong, permalink_url(PermalinkFu.escape(name))))
    end
  end

end
