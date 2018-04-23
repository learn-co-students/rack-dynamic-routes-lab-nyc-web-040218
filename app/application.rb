require 'pry'
class Application
  @@item = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      subbed = req.path_info.gsub("/items/", "")
      # binding.pry
      flag = true
      @@items.each do |el|
        if el.name == subbed
          flag = false
          resp.write(el.price)
        end
      end
      if flag
        resp.write("Item not found")
        resp.status = 400
      end






    else
      resp.write "Route not found"
      resp.status = 404
    end




    resp.finish
  end





end
