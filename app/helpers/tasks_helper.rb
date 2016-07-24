module TasksHelper
  def sortable(column,title, direction)
    link_to title, url_for(params.merge(:sort => column, :direction => direction, :page => nil))
  end
end
