module DrawRoute
  RoutesNotFound = Class.new(StandardError)

  def draw(routes_name)
    drawn_any = draw_route(routes_name)

    drawn_any || raise(RoutesNotFound, "Cannot find #{routes_name}")
  end

  def route_path(routes_name)
    Rails.root.join(routes_name)
  end

  def draw_route(routes_name)
    path = route_path("config/routes/#{routes_name}.rb")
    if File.exist?(path)
      instance_eval(File.read(path))
      true
    else
      false
    end
  end
end

ActionDispatch::Routing::Mapper.prepend DrawRoute