module FontawesomeHelper
  def fa_icon(icon_name)
    content_tag(:i, nil, class: "fa fa-#{icon_name}")
  end
end
