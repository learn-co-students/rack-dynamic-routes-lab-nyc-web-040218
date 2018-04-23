class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      cart = Item.all.map do |item|
        item.name
      end
      item_request = req.path.split("/items/").last
      if cart.include?(item_request)
      items = Item.all.find do |item|
        item.name == item_request
      end
      resp.write items.price
      else
      resp.status = 400
      resp.write "Item not found"
      end

    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end
end
