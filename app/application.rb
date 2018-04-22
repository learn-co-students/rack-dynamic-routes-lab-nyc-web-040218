require 'pry'
class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    # binding.pry

    if req.path.match(/items/)
      cart = Item.all.map{|item| item.name}
      item_request = req.path.split("/items/").last

      if cart.include?(item_request)
        arr = Item.all.find {|item| item.name == item_request}
        resp.write arr.price
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
