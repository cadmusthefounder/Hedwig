module StaticPagesHelper
  def embed
    youtube_id = "nFjRrrpYrWw"
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
  end
end
