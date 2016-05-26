module ApplicationHelper
  include UserAuthentication

  def full_title(title="")
    base_title = "Hedwig"
    if title.empty?
      base_title
    else
      title + " | " + base_title
    end
  end
end
