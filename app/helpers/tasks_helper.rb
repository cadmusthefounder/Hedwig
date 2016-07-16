module TasksHelper
  def sortable(column,title)
    if title == "Newest"
      link_to title, :sort => column, :direction => "ASC"
    else
      link_to title, :sort => column, :direction => "DESC"
    end
  end
end
