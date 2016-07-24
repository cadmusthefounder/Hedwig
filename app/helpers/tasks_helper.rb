module TasksHelper
  def sortable(column,title, direction)
    link_to title, url_for(params.permit(:sort, :direction, :search).merge(:sort => column, :direction => direction, :page => nil))
  end
end
