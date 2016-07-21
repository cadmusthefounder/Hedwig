module TasksHelper
  def sortable(column,title, direction)
    link_to title, :sort => column, :direction => direction
  end
end
