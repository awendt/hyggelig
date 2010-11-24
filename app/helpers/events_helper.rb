module EventsHelper

  def url_preview_for(name)
    if name.blank?
      I18n.t(:'event.url_preview_empty')
    else
      I18n.t(:'event.name_url_preview', :url => content_tag(:strong, permalink_url(PermalinkFu.escape(name))))
    end
  end

  def link_to_facebook_share_for(event)
    link_to("Share on Facebook",
      "http://www.facebook.com/sharer.php?u=#{CGI.escape(permalink_url(:permalink => event.permalink))}&t=#{CGI.escape(page_title)}",
      :class => 'share facebook')
  end

  def link_to_twitter_share_for(event)
    link_to("Share on Twitter",
      "http://twitter.com/home?status=#{CGI.escape(permalink_url(:permalink => event.permalink))}",
      :class => 'share twitter')
  end


end
