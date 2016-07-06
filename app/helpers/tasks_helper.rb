module TasksHelper
  def sortable(column,title)
    puts("Hi")
    if title == "Newest"
      link_to title, :sort => column, :direction => "asc"
    else
      link_to title, :sort => column, :direction => "desc"
    end
  end
end
