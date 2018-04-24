class Application
  milk = Item.new("milk", 5)
  bread = Item.new("bread", 2)

  @@items = [milk, bread]

  def call(env)
    response = Rack::Response.new
    request = Rack::Request.new(env)

    if request.path.match(/items/)
      item_name = request.path.split("/items/").last
      item = @@items.find do |item|
        item.name == item_name
      end

      if item == nil
        response.status = 400
        response.write "Item not found"
      else
        response.write item.price
      end
    else
      response.write "Route not found"
      response.status = 404
    end

    response.finish
  end
end
