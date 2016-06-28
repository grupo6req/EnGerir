module ApplicationHelper
  def activemenu menu_item
    if params[:controller] == menu_item
      "active"
    else
      ""
    end
  end
end
