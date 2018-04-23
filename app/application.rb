class Application

  def call(env)
    res = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item = Item.all.detect {|item| item. name == item_name}
      if item
        res.write item.price
      else
        res.write "Item not found"
        res.status = 400
      end
    else
      res.write "Route not found"
      res.status = 404
    end
    res.finish
  end

end
