module TasksHelper
  def sortable(column,title)
    link_to title, :sort => column, :direction => "DESC"
  end
end
