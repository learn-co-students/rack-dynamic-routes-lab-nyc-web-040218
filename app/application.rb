require "pry"
class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #create a variable item = anything after items/_____
    obj = req.path.split("/").last
    # binding.pry
    names = Item.all.map{|item| item.name}
    if req.path.match("/items/#{obj}") && names.include?(obj)
      wanted_item = Item.all.find{|item| item.name == req.path.split("/").last}
      resp.write wanted_item.price
    elsif req.path.match("/items/#{obj}")
      resp.write "Item not found"
      resp.status = 400
    else
      # binding.pry
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
