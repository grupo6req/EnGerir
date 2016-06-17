module AreasHelper
  def area_as_options area=nil
    areas = Area.all.select(:name, :id).map {|area| [area.name, area.id]}
    if area.nil?
      options_for_select(areas)
    else
      options_for_select(areas, area.id)
    end
  end
end
